# Assigment

I received following test assigment:

    Write service for uploading user videos
    Main tasks:
    * Ability upload video files
    * Ability to list uploaded files and download whem
    * OAuth athorization (vk or facebook)
    * Tests must be present
    * JSON API will be a plus
    * DDOS preventing-realization will be a plus

# Goal and product vision
I want to deliver minimal working product with fast deploy, rspec and cucumber tests, but without DDOS preventing, just limiting simultanious uploads by an user.

Also I need some backstory to make job meanful. Main question is: for what purpose users will be visiting site and upload their videos? If I alreay have video file why I need to upload it to somethere? To share? To archive? To share is so annoying and so widely spread, so I prefer archive idea. How about idea of video archive then you send to your self video in future? You upload video and mark it to show in 09.04.2016 in your birthday? It seems interesting to me.

# File storage
Major question is how to store files. Were are common choices:

* Database - It's obvious doesn't match our needs, but it's worth to mention it. On small projects where you want to keep all data in one file or store all versions of changed files it can be implemented faster than over approach. But drawbacks are: huge files - huge database ram needs, if doesn't fit in ram - performance penalty; web-servers stream files without additional configure, but if you need to stream files from db, you must implement it; direct file access likely faster (in equal conditions);
* Local files - Most common. You calculate grow rate and plan downtime when times come.
* NAS, SAN - Common for enterprise. It needs initial investments and maintenance.
* External storage services:
    * Storage services (amazon s3, rackspace cloud files, dropbox ...) - It's quite easy to use and shifts scale questions to service.
    * Self-hosted storage services - When you want or limited to (corporate, military) use your own infrastructure. I know just a swift as example.

To choose from this options we need to asnwer question: How much data will be generate our users? 

To estimate storage capacity needs we need statistic about file sizes, upload frequencies. We receive this data when service running up. For now make assumptions: 1000 (users) * 3 (videos) * 100 (max file size) = 300 Gb.

If we consider fast grow, but don't know if will it happen. So based on that we choose storage sevice as our file storage. I have satisfied expiriense with s3, and for now I choose Microsoft Azure storage because they offer free trial period. Formely I wanted to use easier option with CloudFiles, but Rackspace from september 2014 no longer offer IaaS without payed customer service.

If we were wrong, we need ability to switch provider or store strategy with minimal effort. Upload libraries solves this. I used paperclip in my recent projects and I have very satisfied with it, and for costumer work I will definetly stick with it. For this job if had enough time I will try refile gem because it's doesn't have ffmpeg transcoder gem, otherwise will stick with paperclip.

# CDN
With cdn you often will get expendable storage (amazon has separated from s3 CDN called CloudFront). If you want get benefits of cdn you must know how distributed location of your users. For ex. if your users live in CIS (Russia, Ukraine, Belarus, ...) then CloudFront and CloudFiles doesn't fit well, are better options will be onapp.com and local players: ngenix.net, айри.рф, cdnvideo.ru. For ex. with CDN you can decrease latency from 120ms to 20ms.

# User stories
* As a registred user I want to be able upload video file.
* As a registred user I want to be able download uploaded file.
* As a registred user I want to receive mail notification in time after file upload.

# Models
* User
* Video
    * Maximum upload file size - 100 Mb

# Mail sending schedule
Two simple strategies to handle sending mail in time are:
* Check every minute is there any videos need to be sended - CPU profit/utilization ratio will be nearly zero.
* Put every uploaded video in array ordered by date - It's better than previous but same sitation and now memory is subject.
We make hybrid: check all not sended videos every hour and limit memory storage with items those need to be shown in next hour. Here we need special check new incoming videos if they are need to be shown in this hour or next.
