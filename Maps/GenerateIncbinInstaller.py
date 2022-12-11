

##      with open(os.path.splitext(fname)[0]+".event", 'w') as myfile:
##        myfile.write(eventfile)
##      installer += "{\n#include \""+os.path.splitext(fname)[0]+".event\"\n}\n"
##
##  if create_installer:
##    with open("Master Map Installer.event", 'w') as f:
##      f.write(installer)
def d(i):
    return int(i, base=16)


ChDefinitions = open("Defs/UnsortedChDefinitions.txt", 'w')
ChDefinitions.write("//Generated. Do not edit!\n") 
ChDefinitions.close()
MapDefinitions = open("Defs/MapDefinitions.txt", 'w')
MapDefinitions.write("//Generated. Do not edit!\n") 
MapDefinitions.close()

MapDefinitions = open("Defs/TileChangeDefinitions.txt", 'w')
MapDefinitions.write("//Generated. Do not edit!\n") 
MapDefinitions.close()

## Chapter and Map Definitions section 
import glob, os
for map_file in glob.glob("Maps/*.tmx"):
    map_file = os.path.basename(map_file).replace(" ", "")
    map_file = map_file.rsplit( ".tmx", 1 ) [ 0 ] 
    with open("Defs/MapDefinitions.txt", 'a+') as f:
      f.write(map_file)
      f.write("Map\n")
    with open("Defs/UnsortedChDefinitions.txt", 'a+') as f:
      f.write(map_file)
      f.write("Ch\n")
    with open("Defs/TileChangeDefinitions.txt", 'a+') as f:
      f.write(map_file)
      f.write("TileChanges\n")
## Create the definition files 
ObjDefinitions = open("Defs/ObjPalDefinitions.txt", 'w')
ObjDefinitions.write("//Generated. Do not edit!\n")
ObjDefinitions.write("//Avoid specific values for vanilla tileset compatibility\n")
## obj 
##avoidList = [0, 1, 0xE, 0x18, 0x2e, 0x3c, 0x42, 0x50, 0x5f, 0x6c, 0x79, 0x88]
## pal 
##avoidList = [0xEA, 0xE6, 2, 0x38, 0x4C, 0x5B, 0xF, 0x72, 0x19, 0x48, 0x57, 0xB9, 0x2F, 0x34, 0x3D, 0x68, 0xCE, 0x43, 0x51, 0x60, 0x6D, 0xA3, 0x7A, 0x89]
## both: 
avoidList = [0, 1, 0xEA, 0xE6, 0xE, 0x18, 0x2e, 0x3c, 0x42, 0x50, 0x5f, 0x6c, 0x79, 0x88, 2, 0x38, 0x4C, 0x5B, 0xF, 0x72, 0x19, 0x48, 0x57, 0xB9, 0x2F, 0x34, 0x3D, 0x68, 0xCE, 0x43, 0x51, 0x60, 0x6D, 0xA3, 0x7A, 0x89]
for i in avoidList:
    ObjDefinitions.write(".avoid ")
    ObjDefinitions.write(str(i))
    ObjDefinitions.write("\n")
ObjDefinitions.close()

## Tile config 
ConfDefinitions = open("Defs/ConfDefinitions.txt", 'w')
ConfDefinitions.write("//Generated. Do not edit!\n")
ConfDefinitions.write("//Avoid specific values for vanilla tileset compatibility\n")
## vanilla values to avoid writing to 
avoidList = [0, 3, 0x10, 0x1A, 0x30, 0x3E, 0x44, 0x52, 0x61, 0x6E, 0x7B, 0x8A]
for i in avoidList:
    ConfDefinitions.write(".avoid ")
    ConfDefinitions.write(str(i))
    ConfDefinitions.write("\n")
    
ConfDefinitions.close()

InstallerDefinitions = open("GeneratedInstaller.event", 'w')
InstallerDefinitions.write("//Generated. Do not edit!\n\n") 
InstallerDefinitions.close()


## Macros 
for obj_file in glob.glob("ConfObj/*.png"):
    obj_file = os.path.basename(obj_file).replace(" ", "")
    obj_file = obj_file.rsplit( ".png", 1 ) [ 0 ] 
    with open("GeneratedInstaller.event", 'a+') as f:
       f.write("ObjTypePalettePointerTable({}Pal,".format(obj_file))
       f.write("{}PalData)\n".format(obj_file))
       
       f.write("ObjTypePalettePointerTable({}Obj,".format(obj_file))
       f.write("{}ObjData)\n".format(obj_file))

## Conf macros 
for conf_file in glob.glob("ConfObj/*.mapchip_config"):
    conf_file = os.path.basename(conf_file).replace(" ", "")
    conf_file = conf_file.rsplit( ".mapchip_config", 1 ) [ 0 ] 
    with open("GeneratedInstaller.event", 'a+') as f:
       f.write("TileConfigPointerTable({}Conf,".format(conf_file))
       f.write("{}ConfData)\n".format(conf_file))



## Incbin section
for obj_file in glob.glob("ConfObj/*.png"):
    obj_file = os.path.basename(obj_file).replace(" ", "")
    obj_file = obj_file.rsplit( ".png", 1 ) [ 0 ] 
    with open("Defs/ObjPalDefinitions.txt", 'a+') as f:
      f.write(obj_file)
      f.write("Obj\n")
      f.write(obj_file)
      f.write("Pal\n")
    with open("GeneratedInstaller.event", 'a+') as f:
    
       f.write("\rALIGN 4\r")
       f.write("{}ObjData:\r".format(obj_file.rstrip()))
       f.write("#incbin \"dmp/{}.dmp\"\r\r".format(obj_file.rstrip()))

       f.write("ALIGN 4\r")
       f.write("{}PalData:\r".format(obj_file.rstrip()))
       f.write("#incbin \"dmp/{}_pal.dmp\"\r\r".format(obj_file.rstrip()))

##import sys, subprocess
## p = subprocess.Popen('Defs/ObjPalDefinitions.txt', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
##subprocess.call(["Defs/Enumerate.bat", "Defs/ObjPalDefinitions.txt"])
##pid = subprocess.Popen([sys.executable, "Defs/ObjPalDefinitions.txt"]) # Call subprocess
##subprocess.Popen(["Defs/ObjPalDefinitions.txt", "Defs/ObjPalDefinitions.txt"] + sys.argv[1:])
## subprocess.run(["Defs/Enumerate.bat", "Defs/ObjPalDefinitions.txt"])

## ObjTypePalettePointerTable(PokecenterObj, OaksLabObjData)
## TileConfigPointerTable(PokecenterConf, OaksLabConfigData)
## ObjTypePalettePointerTable(PokecenterPal, OaksLabPalData)

## Mapchip_config 
for conf_file in glob.glob("ConfObj/*.mapchip_config"):
    conf_file = os.path.basename(conf_file).replace(" ", "")
    conf_file = conf_file.rsplit( ".mapchip_config", 1 ) [ 0 ] 
    with open("Defs/ConfDefinitions.txt", 'a+') as f:
      f.write(conf_file)
      f.write("Conf\n")

    with open("GeneratedInstaller.event", 'a+') as f:
       f.write("ALIGN 4\r")
       f.write("{}ConfData:\r".format(conf_file.rstrip()))
       f.write("#incbin \"dmp/{}_comp.dmp\"\r\r".format(conf_file.rstrip()))



## Macro section

      

##f = open("output.txt", "w")
##f.write("")
##f.close()
##f = open("output.txt", "a")
##f.write("")
##
##temp = open("temp_file.txt", "a")
##
##
##filepath = 'test.txt'
##with open(filepath) as fp:
##   for cnt, line in enumerate(fp):
##       f.write("ALIGN 4\r")
##       f.write("{}ObjData:\r".format(line.rstrip()))
##       f.write("#incbin \"TilesetsB/{}.dmp\"\r\r".format(line.rstrip()))
##
##       f.write("ALIGN 4\r")
##       f.write("{}PalData:\r".format(line.rstrip()))
##       f.write("#incbin \"TilesetsB/{}_pal.dmp\"\r\r".format(line.rstrip()))
##
##       f.write("ALIGN 4\r")
##       f.write("{}ConfigData:\r".format(line.rstrip()))
##       f.write("#incbin \"TilesetsB/{}_comp.dmp\"\r\r\r\r".format(line.rstrip()))
##       
##       # print("Line {}: {}".format(cnt, line))
##
##
###ViridianForestSConfigData:
###incbin "Tilesets/ViridianForestSouth_comp.dmp"
##
##
##
##f.close()

