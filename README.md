# Docker Study
大概花了一周的時間粗淺的學習下Docker的建立，學習的方向大都以工作上會用到的情境為主，目標是取代大家現在使用的那台VM，分別練習了建立空白MCV專案,SQL Server,IIS...。
在撰寫此文件時，原本是要以PPT方式呈現，突發奇想就想把它寫在github上，順便練習markdown的寫法。
## 基本介紹

* 作業系統 **`虛擬化`**
* **`輕量級`** 的作業系統
* **`快速建立`** 與設定開發/測試環境
* 應用程式 **`隔離`**，無論你用什麼語言、工具、或任何系統參數設定，都不會造成容器之間互相影響
* **VM** vs **Container** [[ref]](http://www.inwinstack.com/zh/2017/10/13/vm-container-difference/ "圖片參考")

<img src="http://www.inwinstack.com/wp-content/uploads/2017/10/%E9%9B%BB%E5%AD%90%E5%A0%B11.png" alt="VM" width="45%" height="250"/> <img src="http://www.inwinstack.com/wp-content/uploads/2017/10/%E9%9B%BB%E5%AD%90%E5%A0%B12.png" alt="Container" width="45%" height="250"/>
  
## 安裝環境
目前我使用Windows環境居多，故此介紹Docker for Windows，需求至少需要windows 10以上的環境，且需要開啟 Hyper-V

[官方安裝說明](https://store.docker.com/editions/community/docker-ce-desktop-windows "Docker Community Edition for Windows")
[安裝檔](https://download.docker.com/win/stable/Docker%20for%20Windows%20Installer.exe "Docker for Windows")

[[ref]](https://skychang.github.io/2017/01/06/Docker-Docker_for_Windows_10_First/)
![Hyper-V](https://skychang.github.io/2017/01/06/Docker-Docker_for_Windows_10_First/01.png)
## Docker
* Image 
* Containers
* Dockerfile
## 工作上使用情境 
依目前工作上(專案)的需求，通常需要 1 AP , 1 DB or 1 GIS Server。我們目前使用VM為主，一台機器能裝載的虛擬機有限，相較於Docker是比較吃資源的，即使只需要一個DB，也是需要裝上一層厚重的OS來包裝它。

以Docker而言，可以建立幾個常用環境的image；當環境建立初期，只需要拿出曾經建好的image，幾個指令即可將環境練立好並馬上使用。

GIS Server的架設因我本身不熟，這次雖然有列在練習目標內，但只有查了一些資料，確定是可行的，不過沒有花時間在練習架設，相關的參考都會放在 [參考資料](#參考資料) 中。
## 指令筆記
以下是我在執行時常用到的指令，僅列出docker部分，其餘需要使用一些CMD。
### Image相關
```bash
# 下載image
docker pull $IMAGE  (microsoft/aspnet,microsoft/mssql-server-windows-developer,...)

# 查看image
docker images

# 刪除指定image (name or ID)
docker image rm $IMAGE

# 釋放 無使用的image
docker image prune -a

# 以目錄下的Dockerfile建立image (須以" ."結尾)
docker build -t $NAME .
```
### Container相關
```bash
#查詢建立的Container
docker ps -a 

#start Container
docker start $Container

#stop Container
docker stop $Container

# 以image建立此Container
docker run -d --name $NMAE $IMAGE
------------------------------------------
docker pull microsoft/aspnet
docker pull microsoft/mssql-server-windows-developer
docker run -d -m 4g --name $NMAE -e ACCEPT_EULA=Y -e SA_PASSWORD=1qaz2wsx#EDC -p 1433:1433 microsoft/mssql-server-windows-developer

# 進入Container
docker exec -it $NMAE cmd

# 查詢IP
docker inspect -f "{{ .NetworkSettings.Networks.nat.IPAddress }}" $NMAE

# 複製檔案到Container裡
docker cp ./TPGISSSO/Web.config $NMAE:/inetpub/wwwroot/TPGISSSO/Web.config
```
## 個人註記
* pull IMAGE時，有時候會一直下載失敗，下載時候請注意網路狀況是否良好。
* pull IMAGE後的解壓縮，會因不明原因失敗，嘗試了半天，一次是restart docker成功，但大多都是重開機後重新下載才完成。
* 下載完整版的image其實挺占空間的，SQL Server或者aspnet一個都有10G以上，這次練習結束大概用了近50G的空間，使用Linux版本的image相較之下會省非常多的空間。

## 參考資料
1. [Docker - Docker for Windows 10 入門篇 | 天空的垃圾場](https://skychang.github.io/2017/01/06/Docker-Docker_for_Windows_10_First/)
2. [將 ASP.NET MVC 應用程式遷移到 Windows 容器 | Microsoft Docs](https://docs.microsoft.com/zh-tw/aspnet/mvc/overview/deployment/docker-aspnetmvc)
3. [快速上手 Windows Containers 容器技術 (Docker Taipei)](https://www.slideshare.net/WillHuangTW/windows-containers-docker-taipei)
4. [IT人蔘: Windows Containers 容器技術 - 建立IIS容器](http://it-ginseng.blogspot.com/2018/02/windows-containers-iis.html)
5. [無法刪除Docker資料夾中的windowsfilter目錄 | Edward.K Tech Road](https://edwardkuo.imas.tw/paper/2017/03/09/Docker/Deletewindowsfilter/)
6. [[Docker]使用 Docker for Windows 來運行 ASP.NET WebForms | 亂馬客 - 點部落](https://dotblogs.com.tw/rainmaker/2017/01/05/181153)
7. [Day20：介紹 Docker 的 Network (一) - iT 邦幫忙::一起幫忙解決難題，拯救 IT 人的一天](https://ithelp.ithome.com.tw/articles/10193291?sc=iThelpR)
8. [docker image prune命令 - Docker教程™](https://www.yiibai.com/docker/image_prune.html)
9. [Deploying ArcGIS Server using Docker | GeoNet](https://community.esri.com/thread/166654)
10. [Geo-CEG · GitHub](https://github.com/Geo-CEG)
11. [ArcGIS Server site with Esri ArcGIS Server Docker deployed in AWS ECS.](https://s3.amazonaws.com/arcgisstore1051/7333/docs/ReadmeECS.html)
12. [30-2之使用Docker來建構MongoDB環境 - iT 邦幫忙::一起幫忙解決難題，拯救 IT 人的一天](https://ithelp.ithome.com.tw/articles/10184657)
