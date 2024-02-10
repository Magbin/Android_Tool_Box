print("Welcome use Android_tool")
print("Android_tool by @zll")
print("此工具集成Android分区解包打包和全自动修复bug")
print("未经允许，禁止倒卖")
print("版本号：dev.1.0.0")
# =================================================
print("项目内容")
print("【1】打开小米ROM官网                  【2】创建项目")
print("【3】全自动编译内核                   【4】将设备进行格式化")
print("【5】解压ROM")
# =================================================
import webbrowser
import os
import zipfile
import subprocess


num = int(input("请输入你要进行的项目序号"))
if num == 1:
    webbrowser.open("xiaomirom.com")
# ===========================================================
if num == 5:
    current_directory = os.getcwd()
    for filename in os.listdir(current_directory):
        if filename.endswith(".zip"):
            print("发现ZIP文件:", filename)

            zip_file_path = os.path.join(current_directory, filename)
            extracted_folder_name = os.path.splitext(filename)[0]
            extracted_folder_path = os.path.join(current_directory, extracted_folder_name)
            with zipfile.ZipFile(zip_file_path, 'r') as zip_ref:
                zip_ref.extractall(extracted_folder_path)

            print(f"解压完成: {filename} -> {extracted_folder_name}")
# =============================================================
if num == 2:
    script_directory = os.getcwd()
    name = input("请输入文件夹名称")
    os.mkdir(name)
    print("创建成功")
    print("请将你要分解的文件移动进文件夹")
    folder_path = name
    os.chdir(folder_path)
    print("[1]分解img   [2]分解bin")
    print("[3]合成img   [4]打包img")
    pro = int(input("请输入项目序号"))
    while pro == 1:
        print("请输入要分解的镜像")
        dir_path = r''
        res = os.listdir(dir_path)
        print(res)
        adb = input("请输入你要分解的镜像名称（不带.img）")
        # 开始分解项目
        while adb == input('system'):
            result = subprocess.run(['simg2img system.img system.img.ext4'], capture_output=True, text=True)
            print(result.stdout)
            break
        while adb == input('vendor'):
            result = subprocess.run(['simg2img system.img vendor.img.ext4'], capture_output=True, text=True)
            print(result.stdout)
            break
        while adb == input('product'):
            result = subprocess.run(['simg2img product.img product.img.ext4'], capture_output=True, text=True)
            print(result.stdout)
            break
        while adb == input('system_ext'):
            result = subprocess.run(['simg2img system_ext.img system_ext.img.ext4'], capture_output=True, text=True)
            print(result.stdout)
            break
        break
    # ===========
    while pro == 2:
        print("此功能尚未开发")
        break
    while pro == 3:









