---
layout: post
title: 'Docker Introduction'
date: 2019-01-01 04:54:35
tags:
- Technology
- Tutorial
- Docker
- Basic
cover: https://www.marksei.com/wp-content/uploads/2017/01/Docker-Logo.jpg
---
![](https://www.marksei.com/wp-content/uploads/2017/01/Docker-Logo.jpg)
Yo :> Assalamualaikum, Salam Sejahtera.. kali ini kita akan membahas sedikit tentang apa itu [`docker`](https://docker.com) dan dasar penggunaan docker :> dari kutipan [docs.docker](https://docs.docker.com/get-started/) tertulis:
__Docker is a platform for developers and sysadmins to develop, deploy, and run applications with containers. The use of Linux containers to deploy applications is called containerization. Containers are not new, but their use for easily deploying applications is.__ 

tau nggak artinya? :v wkwk jadi disitu dikatakan __Docker adalah sebuah platform untuk `developer`/pengembang dan [system administrator](https://en.wikipedia.org/wiki/System_administrator) untuk pengembangan, memasang, dan menjalankan sebuah aplikasi dengan `container`__, dan biasanya base dari `container` itu sendiri dari OS `linux` atau system operasi UNIX. lalu kenapa harus pakai docker ? :> ok, dari sini saya akan cerita sedikit.

> ## Introduction

Pernah nggak sih kita membuat sebuah program katakanlah `web apps`, biasanya ketika kita mengembangkan sebuah program kita hanya menguji pada laptop/device kita sendiri tentu saja dengan environment kita yang sudah terpasang. dan pernah nggak kalian itu waktu develop sebuah program waktu di laptop/device bisa di __running__ tapi waktu di pindah tangankan/device lain itu nggak bisa di __running__ ? :> kalau pernah berarti kita sama :> hehe, 

Ada lagi sebuah kasus dimana ketika kita membuat sebuah microservice yang sudah terlalu kompleks dan membutuhkan banyak sekali program pendukung di OS kita, misal [laravel](https://laravel.com) dengan `php dsb,` [express](https://expressjs.com) dengan `node dsb`, dan [Django](https://www.djangoproject.com/) dengan `python dsb`... bisa nggak kalian bayangkan betapa banyaknya program/package yang akan terinstall di OS kalian ? :> belum lagi misal kita ada suatu program yang hanya beda versi ? misal laravel4 dengan php5 dan laravel5 dengan php7 :> pasti disitu kita akan kesulitan dengan hanya dengan satu device :> 
```md
  [NOTE] --- Device disini bisa kita anggap sebagai server juga.
```
lalu apa hubungannya dengan `docker` :> hmm
salah satu fitur Docker yaitu `containerization` adalah fitur yang sangat membantu ketika kita mengembangkan, memasang, atau menjalankan sebuah program dengan berbagai __environment__ tanpa perlu kita memasang `environment` tersebut di OS kita :> sampe sini dapet nggak? docker menggunakan __container__ untuk mengisolasi sebuah environment untuk kita gunakan sebagai wadah program yang akan kita jalankan. 
```md
  [NOTE] --- environment maksudnya adalah program pendukung, eg: php, node, pyhton.. 
```

Jadi simple nya konsep docker itu kayak kita menggunakan sebuah tool yaitu [VirtualBox](https://www.virtualbox.org/), kita bisa memanajemen Mesin Virtual (VitrualMachine) sesuai kebutuhan dengan konsep **Container**. Lalu apa bedanya kita menggunakan VM? hmm :> dibawah ini beberapa perbedaan yang saya rasakan.

1. Resource Usability
VM hanya bisa dirunning ketika kita ada sebuah __Operating System__(OS) didalamnya dan berbeda dengan `Docker`, karena konsep docker adalah sebagai __service__ atau program kecil yang berjalan, lebih hemat dalam penggunaan memory dan cpu. dan container juga memiliki fitur `DRS` __Distribute Resource Sharing__. namun setiap container juga bisa di set berapa spesifikasi nya sesuai kebutuhan.
2. Fleksibility
Environment menggunakan docker lebih fleksibel, karena semua kebutuhan environment akan terisolasi pada Container. dalam hal ini tidak melibatkan __HOST__ yang dipakai, jadi host akan bersih dari package-package yang mungkin bisa betubrukan :>
3. Re-Booting / Restart
Perbandingan Container dengan VM pada saat booting `restart` service jauh berbeda, container booting ulang tidak sampai 10detik karena hanya memuat proses-proses kecil. *tergantung proses yang dijalankan.
4. Availability
seperti VM pada umumnya, container juga dapat dicluster.. dan mengcluster pada `docker` jauh lebih mudah karena sudah terdapat perintah di docker tersebut. jadi misalkan kita punya suatu program yang load nya sudah tinggi, kita bisa melakukan scalling untuk menjaga load tetap stabil :>

> ## Docker Basic Command Line

Selanjutnya kita akan belajar sedikit Basic CLI pada docker, tp sebelum kita beranjak ke jenjang yang lebih tinggi :> wkwk maksud saya pengenalan selanjutnya pastikan di device/PC/laptop kalian sudah terinstall `docker`, jika ada yang belum memasang docker.. kalian bisa memasang dengan membaca [dokumentasi](https://docs.docker.com) atau bisa menggunakan [installer](https://github.com/abas/docker-install) yang sudah saya buat :> 

Oke, Jadi Docker CLI itu sama seperti [CLI](https://en.wikipedia.org/wiki/Command-line_interface) pada dasarnya. setiap __binary__ program biasanya terdapat sebuah perintah untuk memunculkan info / perintah apa saja yang bisa digunakan dari program tersebut. contoh simpel.
```sh
  $ echo "hello world"
```
perintah `echo` merupakan sebuah program bawaan `bash/shell` yang ditulis menggunakan bahasa C untuk standar pengeluaran(output). untuk melihat dokumentasi / manual penggunaan dari sebuah program bisa menggunakan perintah `man`, kita ambil lagi contoh dari program `echo`.
```sh
  $ man echo
```
`man` akan menampilkan dokumentasi / manual penggunaan dari target program :> dan juga ada cara lain yaitu menggunakan sebuah `option/parameter` dari progam tsb, misal kan dari sini kita ambil contoh `Docker`
```sh
  $ docker -h # atau
  $ docker --help
```
![](/images/asset/docker-cli.jpg)
diatas adalah hasil output dari `docker --help` namun karena ini __basic__ jadi kita akan membahas docker command yang sering digunakan dan paling dasar dari sebuah `Docker` :>

> ### Pull, Build, Run, Exec...

### --- Docker `Pull`
```sh
  $ docker pull --help
  # Usage:  docker pull [OPTIONS] NAME[:TAG|@DIGEST]
```
`docker pull` adalah suatu perintah docker untuk __menarik/download__ suatu image dari repository [dockerhub](https://hub.docker.com) atau dari registry local dan lain-lain. jadi misalkan kita ingin mengunduh image katakanlah ingin membuat container `webserver`(apache2/httpd/nginx/etc) maka kita harus mempunyai image terlebih dahulu :> oke misalnya seperti ini.
```sh
  $ docker pull nginx:1.15.1
  #ketika kalian melihat tutorial terkadang juga ada yang seperti ini
  $ docker pull kankuu/nginx-loadbalancer:alpha
```
kita lihat lagi __basic Usage__ diatas ya :> terdapat beberapa suku kata bukan ? `docker`, `pull`, `[option]`, `name[:tag|@digest]` sebelum melangkah yang lebih jauh :> kita pahami satu2 suku kata tersebut, Ok. dari `docker` -> ini merupakan perintah dari program docker.. kemudian yang kedua adalah `pull` -> ini merupakan sebuah __option command__ dari perintah docker *check kembali `docker --help`, kemudian yang ketiga ada `[option]` ini merupakan opsi dari perintah `docker pull --help`, kemudian ada `name[:tag|@digest]` ini merupakan kesatuan dari `3 element` apa itu? :> pertama adalah `username` pada dockerhub, kedua adalah `image-name` dan ketiga adalah `tag-name`.

Jadi misalkan perintahnya seperti baris yang kedua diatas, yaitu `docker pull kankuu/nginx-loadbalancer:alpha` suku kata ketiga yaitu `kankuu/nginx-loadbalancer:alpha` akan kita cermati sebagai berikut :
- `kankuu` : username dari user yang ada di dockerhub
- `nginx-loadbalancer` : nama images yang dibuat oleh user kankuu
- `alpha` : merupakan nama tag dari images yang tersedia.
lalu dimana kita bisa melihat tag yang tersedia, ada di colom [Tag](https://cloud.docker.com/repository/docker/kankuu/nginx-loadbalancer/tags) :> sampai disini sudah paham ya. untuk selebihnya bisa kalian coba-coba sendiri di device/PC/laptop kalian.
```md
  [NOTE] --- apabila tag tidak diisi dia otomatis menggunakan tag :latest:
```

### --- Docker `Build`
```sh
  $ docker build --help
  # Usage:  docker build [OPTIONS] PATH | URL | -
```
`docker build` adalah suatu perintah untuk membuat sebuah images dari beberapa baris code di sebuah file [Dockerfile](https://docs.docker.com/engine/reference/builder/) atau `*.dockerfile` tujuannya adalah untuk menkostum images dengan spesifikasi yang hanya kita butuhkan, istilah simpel nya kita membuat kostum images. kita bisa membuat images itu dari awal `FROM SCRATCH` atau bisa juga __memodifikasi__ images dari repository `dockerhub`, misalkan nih.. kita ada image `nginx` namun didalam image itu tidak ada [nano](https://www.nano-editor.org/) jadi kita bisa membuat `Dockerfile` dengan spesifikasi berikut.
```Dockerfile
# filename : Dockerfile
FROM nginx:1.15.1

RUN apt-get update && \
    apt-get install -y nano
```
lalu untuk `build` images nya kita gunakan perintah berikut :
```sh
  $ docker build -t kankuu/nginx-nano:latest .
```
seperti pada __basic usage__ nya, `build` merupakan sebuah parameter opsi dari command docker, dan parameter `-t` adalah sebuah opsi parameter untuk penamaan/`tagging` untuk images yang akan di build. perintah tersebut akan mendeteksi secara otomatis file `Dockerfile` yang kita buat, apabila kita ingin menggunakan lebih dari satu `Dockerfile` maka kita bisa membuat file dengan ekstensi `.dockerfile`, jadi katakanlah Dockerfile tadi kita buat 2 kostumisasi images, yang pertama nginx yang ada paket `nano` dan nginx yang ada paket `wget/curl`.
```dockerfile
# filename nginx-nano.dockerfile
FROM nginx:1.15.1

RUN apt-get update && \
    apt-get install -y nano
```
lalu pada nginx yang ada paket `wget/curl`
```dockerfile
# filename : nginx-curl.dockerfile
FROM nginx:1.15.1

RUN apt-get update && \
    apt-get install -y wget curl
```
lalu apakah cara build images nya sama? hmm agak berbeda sedikit.. hehe :> dari sini kita akan menggunakan parameter opsi `-f` atau `--file`. seperti pada perintah berikut :
```sh
  $ docker build -f nginx-nano.dockerfile -t kankuu/nginx-nano:latest .
  # atau
  $ docker build --file nginx-curl.dockerfile -t kankuu/nginx-curl:latest .
```
dari sini kelihatan kan bedanya ? jadi satu root folder kita bisa menggunakan banyak `Dockerfile`, namun semua itu bergantung kalian masing-masing karena kenyamanan setiap orang berbeda-beda :> jika bingun dengan perintah `docker build` kalian bisa melihat dari dokumentasi `docker build --help` :> 


### --- Docker `Run`
```sh
  $ docker run --help
  # Usage:  docker run [OPTIONS] IMAGE [COMMAND] [ARG...]
```
`Docker Run` merupakan sebuah perintah untuk membuat _container_ dari sebuah images, coba kalian ketikan `docker run --help` di console kalian maka akan terdapat banyak sekali opsi untuk membuat sebuah _container_ seperti yang kita bahas diatas, container itu seperti sebuah VM, hanya saja container berfokus pada satu service, yang artinya dia hanya berdiri untuk environment yang dibutuhkan saja. 

misalkan kita ingin membuat sebuah _container_ [loadbalance](https://www.nginx.com/resources/glossary/load-balancing/) dari sebauh images maka kita hanya perlu menambahkan package yang bisa menangani loadbalance tersebut. dalam kasus ini saya biasanya menggunakan [nginx](https://www.nginx.com), kenapa ? disisi dia bisa sebagai _reverse proxy_ dia juga bisa sebagai webserver, dan tentu saja _nginx_ memiliki fitur sebagai loadbalancer :> oke mari kita coba cara sederhana untuk membuat sebuah kontainer.
```sh
  # membuat container ubuntu
  $ docker run -d ubuntu
  # output :
  # --- 04109269829d8c027a01394d9dc37b8bdda49792fffbd96ea67434b5d07593aa ,etc
```
kita pahami dulu dasar perintah dari `docker run`, dari __basic Usage__ yang perlu kita perhatikan adalah `[OPTION]`, `IMAGE`, dan `[COMMAND]`. dari perintah cara membuat container ubuntu diatas terdapat sebuah parameter __[OPTION]__ yaitu `-d / --detach` atau bisa kita sebut _detach_, yang artinya container akan berjaan pada latarbelakang. kemudian `ubuntu` adalah sebuah __[IMAGES]__ yang akan kita jadikan base `service` untuk container itu sendiri. lalu kemana parameter [COMMAND] ? dalam kasus ini kita tidak menggunakannya karena default dari command ketika kita membuat container ubuntu adalah command `bash`. lalu bagaimana cara kita bisa melihat container apa saja yang sudah kita buat ? :>
> Command untuk `Check` container yang sudah kita buat

```sh
  $ docker ps
  # docker ps --help <- untuk melihat opsi dari [docker ps]
```
`docker ps` hanya akan menampilkan container dengan status `UP`, jika ada container dengan _Status_ selain `UP` dia tidak akan tampil disini. jika kita ingin melihat container dengan status _all_ artinya apapun itu status nya tetap di tampilkan :> kita bisa menambahkan sebuah parameter `-a` sesudah `ps`. jadi perintahnya akan menjadi seperti ini
```sh
  $ docker ps -a
  # untuk melihat container yang terakhir kita buat
  $ docker ps -l
```
jika kita lihat pada kolom _Names_ terdapat sebuah nama yang _random_, itu disebabkan karena kita tidak menamai container nya, dan _Status_ nya `Exited` yang artinya container tersebut __DOWN__. kita juga bisa memfariasi output dari `docker ps` dengan parameter `--format`, misalkan kita hanya ingin menampilkan colom _nama container_, _status_, dan _port_. maka kita akan menggunakan `--format` seperti perintah berikut.
```sh
  $ docker ps -a --format 'table {{.Names}}\t {{.Status}}\t {{.Ports}}'
```
referensi bisa kalian lihat di dokumentasi docker officialnya [disini](https://docs.docker.com/engine/reference/commandline/ps/). sampai disini paham untuk `docker ps`? :> jika belum paham bisa baca-baca di dokumentasinya dulu. 

Sekarang kita coba untuk membuat sebuah container webserver menggunakan `nginx`. tapi sebelumnya saya jelaskan kenapa sih harus pakai container untuk sebuah webserver ? :> hehe, biasanya kan kita tinggal install lewat package manager `apt`, `yum`, `etc`.. sebenarnya ini tergantung kebutuhan kita juga, kita bisa saja memasang webserver di _host_ kita kemudian untuk service-service yang ada dipasang ke container. akan tetapi jika suatu saat kita menemukan/melakukan sebuah kesalahan pada webserver _host_ kita, yang kita sendiri tak tau kenapa dan terpaksa _re-install_ webserver kita itu akan sangat merepotkan bukan ? belum lagi file-file yang mungkin sudah kita config selama ini malah hilang :"> ehehe ya itu dari segi sederhananya, ada beberapa pendapat yang sebenarnya lebih bagus semua itu di container, ada juga yang tidak, karena semua itu juga kebutuhan kita masing-masing :> oke lanjut cara buat container webserver
```sh
  $ docker run -d --name webserver-nginx -p 80:80 --restart always nginx:1.15.1
```
untuk opsi `-p` atau bisa `--port` adalah sebuah opsi untuk menambahkan port pada container tersebut, lalu apa perbedaan `80` didepan dengan `80` dibelakang ? :> hehe jadi `80` didepan adalah sebuah port yang diexpose oleh `docker` yang artinya dia dapat di akses dari local/public, sedangkan `80` dibelakang adalah sebuah port yang hanya bisa diakses antar container dengan _network_ yang sama. Istilah sederhananya adalah seperti [port forwarding](https://en.wikipedia.org/wiki/Port_forwarding), dengan konsep gambar sederhana seperti berikut.
```md
dari dalam container -> open port 80/tcp [dalam container] -> expose port 80/tcp ke port 80/tcp host <- public/localhost accessable
```
kita bisa saja merubah expose port semau kita, tapi port dalam container tidak bisa kita ubah dengan sembarangan :> jadi misalkan kita akan membuat webserver dengan _custome_ port `7000`. maka perintah nya akan jadi seperti berikut.
```sh
  $ docker run -d --name webserver-nginx -p 7000:80 nginx:1.15.1
```
maka dari konsep dasar port forwarding, port `80/tcp` dadi dalam container akan di forward keluar container(host) sebagai port `7000/tcp` :> kemudian coba kalian cek dengan `docker ps -l` jika _Status_ container `UP` maka kalian bisa langsung mengecek dari browser kalian dengan alamat url `localhost:7000` :> atau bisa menggunakan `curl localhost:7000`.


### --- Docker `Exec`
```sh
  $ docker exec --help
  # Usage:  docker exec [OPTIONS] CONTAINER COMMAND [ARG...]
```
`Docker Exec` merupakan sebuah perintah dasar docker untuk melakukan _execution_/eksekusi sebuah perintah langsung kedalam sebuah container, konsep dari `docker exec` seperti ketika menggunakan [ssh](https://en.wikipedia.org/wiki/Secure_Shell) ke sebuah server, contoh simpel penggunaan `ssh exec` misalnya `ssh user@host_target eksekusi_perintah`, misal aku ingin mengirim sebuah perintah pada server `kankuu` dengan user `root`.
```sh
  $ ssh root@kankuu echo "hello, i am $USER"
```
jadi perintah `echo "hello, i am $USER"` akan di kirim ke server _kankuu_ dengan user __root__, dan hal ini tidak jauh berbeda ketika kita menggunakan `docker exec` hanya berbeda perlakukuan :> jika `ssh` _mengirim perintah ke server_ maka `docker exec` __mengirim perintah ke container__ :> dan jika kalian cermati kembali dasar pengunaan diatas ada sebuah parameter _CONTIANER_ dan _COMMAND_, yang artinya container adalah target container yang ingin kita masukkan sebuah perintah, dan command adalah perintah yang akan kita jalankan di dalam kontainer tersebut. misalkan seperti contoh dibawah ini
```sh
  $ docker exec con_ubuntu echo "hello, i am $USER"
```
jadi `con_ubuntu` disitu adalah sebuah nama container nya, dan parameter setelah `con_ubuntu` adalah sebuah command/perintah yang akan kita jalankan di dalam kontainer `con_ubuntu`. perlu dicatat bahwa _container tidak akan bisa dimasukkan sebuah perintah jika status kontainer tersebut mati atau DOWN_ lalu bagaimana cara masuk kedalam container ? jika dibandungkan dengan VM kita bisa menggunakan SSH tapi untuk kontainer kita perlu tau shell handler atau bisa kita sebut `sh/bash`. maka kita untuk masuk kebuah kontainer kita cukup menjalankan command seperti dibawah.
```sh
  $ docker exec -ti container_name bash #- jika tidak bisa
  $ docker exec -ti container_name sh
```
tidak semua images sudah terinclude `bash` shell, tapi untuk `sh` itu pasti. untuk keterangan `-ti` kalian bisa melihat nya pada dokumentasi `docker exec --help` :>

> ## Conclusion

perintah-perintah diatas adalah sebuah perintah dasar dalam menggunakan docker :> walaupun sebernanya setiap orang berbeda dalam hal dasar, namun sepengalaman saya 4 perintah dasar yang sering saya gunakan dan mungkin akan kalian gunakan juga. masih banyak perintah-perintah dasar jika kalian mau membuka dokumentasi dari `docker --help` meskipun jarang dipakai tapi ada saat dimana kalian bakal menggunakan perintah tersebut :> 

Ok, Terimakasih Sudah mau Membaca Tulisan ini, 
jika ada pertanyaan silahkan contact [telegram](https://t.me/kankuu) saya jika kalian masih bingung.
saya open saran dan kritikan tengan blog saya.
karena saya juga masih belajar :>
\-Sekian :>