#!/usr/bin/env python
import os, subprocess, shlex, datetime, sys, plistlib, tempfile, shutil, random, uuid, zipfile, json
from Scripts import *
from collections import OrderedDict
# Python-aware urllib stuff
if sys.version_info >= (3, 0):
    from urllib.request import urlopen
else:
    from urllib2 import urlopen

class Smbios:
    def __init__(self):
        self.u = utils.Utils("GenSMBIOS")
        self.d = downloader.Downloader()
        self.r = run.Run()
        self.macinfopkg_url = "https://api.github.com/repos/acidanthera/MacInfoPkg/releases"
        self.opencorpgk_url = "https://api.github.com/repos/acidanthera/OpenCorePkg/releases"
        self.scripts = "Scripts"
        self.plist = None
        self.plist_data = None
        self.plist_type = "Unknown" # Can be "Clover" or "OpenCore" depending
        self.remote = self._get_remote_version()
        self.okay_keys = [
            "SerialNumber",
            "BoardSerialNumber",
            "SmUUID",
            "ProductName",
            "Trust",
            "Memory"
        ]

    def _get_macserial_version(self):
        # Attempts to determine the macserial version from the latest OpenCorPkg
        try:
            urlsource = json.loads(self.d.get_string(self.opencorpgk_url,False))
            macserial_h_url = "https://raw.githubusercontent.com/acidanthera/OpenCorePkg/{}/Utilities/macserial/macserial.h".format(urlsource[0]["target_commitish"])
            macserial_h = self.d.get_string(macserial_h_url,False)
            macserial_v = macserial_h.split('#define PROGRAM_VERSION "')[1].split('"')[0]
        except: return None
        return macserial_v

    def _get_macserial_url(self):
        # Gets a url to the latest version of OpenCorePkg
        try:
            urlsource = json.loads(self.d.get_string(self.opencorpgk_url,False))
            return next((x.get("browser_download_url",None) for x in urlsource[0].get("assets",[]) if "RELEASE.zip" in x.get("name","")),None)
        except: pass
        return None

    def _get_macserial_version_linux(self):
        # Get the latest version of macserial
        try:
            urlsource = json.loads(self.d.get_string(self.macinfopkg_url,False))
            return urlsource[0].get("tag_name",None)
        except: pass # Not valid data
        return None

    def _get_macserial_url_linux(self):
        # Get the latest url of macserial - we'll leverage this for linux users
        try:
            urlsource = json.loads(self.d.get_string(self.macinfopkg_url,False))
            return next((x.get("browser_download_url",None) for x in urlsource[0].get("assets",[]) if "linux.zip" in x.get("name","")),None)
        except: pass # Not valid data
        return None

    def _get_binary(self,binary_name=None):
        if not binary_name:
            binary_name = ["macserial.exe","macserial32.exe"] if os.name == "nt" else ["macserial"]
        # Check locally
        cwd = os.getcwd()
        os.chdir(os.path.dirname(os.path.realpath(__file__)))
        path = None
        for name in binary_name:
            if os.path.exists(name):
                path = os.path.join(os.getcwd(), name)
            elif os.path.exists(os.path.join(os.getcwd(), self.scripts, name)):
                path = os.path.join(os.getcwd(),self.scripts,name)
            if path: break # Found it, bail
        os.chdir(cwd)
        return path

    def _get_version(self,macserial):
        # Gets the macserial version
        out, error, code = self.r.run({"args":[macserial]})
        if not len(out):
            return None
        for line in out.split("\n"):
            if not line.lower().startswith("version"):
                continue
            vers = next((x for x in line.lower().strip().split() if len(x) and x[0] in "0123456789"),None)
            if not vers == None and vers[-1] == ".":
                vers = vers[:-1]
            return vers
        return None

    def _download_and_extract(self, temp, url, path_in_zip=[]):
        ztemp = tempfile.mkdtemp(dir=temp)
        zfile = os.path.basename(url)
        self.d.stream_to_file(url, os.path.join(ztemp,zfile), False)
        btemp = tempfile.mkdtemp(dir=temp)
        # Extract with built-in tools \o/
        with zipfile.ZipFile(os.path.join(ztemp,zfile)) as z:
            z.extractall(os.path.join(temp,btemp))
        script_dir = os.path.join(os.path.dirname(os.path.realpath(__file__)),self.scripts)
        search_path = os.path.join(temp,btemp)
        # Extend the search path if path_in_zip contains elements
        if path_in_zip: search_path = os.path.join(search_path,*path_in_zip)
        for x in os.listdir(search_path):
            if "macserial" in x.lower():
                # Found one
                if os.name != "nt":
                    self.r.run({"args":["chmod","+x",os.path.join(search_path,x)]})
                if not os.path.exists(script_dir):
                    os.mkdir(script_dir)
                shutil.copy(os.path.join(search_path,x), os.path.join(script_dir,x))

    def _get_macserial(self):
        # Download both the windows and mac versions of macserial and expand them to the Scripts dir
        # Check if Linux - as that only gets the old version
        if sys.platform.startswith("linux"):
            url = self._get_macserial_url_linux()
            path_in_zip = []
        else:
            url = self._get_macserial_url()
            path_in_zip = ["Utilities","macserial"]
        if not url:
            return
        temp = tempfile.mkdtemp()
        cwd  = os.getcwd()
        try:
            self._download_and_extract(temp,url,path_in_zip)
        except Exception as e:
          temp=1
        os.chdir(cwd)
        shutil.rmtree(temp)
        return

    def _get_remote_version(self):
        if sys.platform.startswith("linux"):
            vers = self._get_macserial_version_linux()
        else:
            vers = self._get_macserial_version()
        if not vers:
            return None
        return vers

    

    def _get_smbios(self, macserial, smbios_type, times=1):
        # Returns a list of SMBIOS lines that match
        total = []
        while len(total) < times:
            total_len = len(total)
            smbios, err, code = self.r.run({"args":[macserial,"-a"]})
            if code != 0:
                # Issues generating
                return None
            # Got our text, let's see if the SMBIOS exists
            for line in smbios.split("\n"):
                line = line.strip()
                if line.lower().startswith(smbios_type.lower()):
                    total.append(line)
                    if len(total) >= times:
                        break
            if total_len == len(total):
                # Total didn't change - return False
                return False
        # Have a list now - let's format it
        output = []
        for sm in total:
            s_list = [x.strip() for x in sm.split("|")]
            # Add a uuid
            s_list.append(str(uuid.uuid4()).upper())
            # Format the text
            output.append(s_list)
        return output

    def _generate_smbios(self, macserial):
        if not macserial or not os.path.exists(macserial):
            # Attempt to download
            self._get_macserial()
            # Check it again
            macserial = self._get_binary()
            if not macserial or not os.path.exists(macserial):
                # Could not find it, and it failed to download :(
                return

        smtype = "MacBookPro14,1"
        times  = 1
        smbios = self._get_smbios(macserial,smtype,times)
        
        print("\n\n".join(["SystemSerialNumber={}\nMLB={}\nSystemUUID={}".format(x[1], x[2], x[3]) for x in smbios]))


    def main(self):
        self._generate_smbios(self._get_binary())

s = Smbios()

s.main()
