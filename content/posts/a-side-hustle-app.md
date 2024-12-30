---
title: "A side hustle app"
date: 2023-07-16T13:38:12+10:00
tags: ["hustle", "mobile", "app", "ios", "flutter", "indie", "utilities", "shopping", "reminder", "saving"]
draft: true
---

For the last 4 months, I have been working on a mobile app. This is not the first time I started something, yet finally this is the first one I actually make it to the public. In this blog post, I just want to share some more details about this side hustle project, a boring mini mobile app, called **itemeter**.

## How it started

My wife and I usually went shopping together since forever, but recently, when we had our second child, it's more often that we have to split the household duties. In particularly, one of us would go shopping with the older kid, while the other stays home and looks after the younger one. We used to create the list of items to buy in the [Notes](https://apps.apple.com/us/app/notes/id1110145109) app, then share it with each other. It worked out pretty well for the most part. You can check off the item you bought. You can take photo, etc. However, at some point it becomes a bit harder for us to keep track of everything. It's not super easy to find or (impossible) to remember all the things we need to buy. Somehow, we always missed a thing or two. It's annoying that sometime you have to go to the shop just to get one single item. So, here's an idea. It's dead simple. It's a shopping list (kinda like a Todo list) plus reminding feature. My wife and I talked about it. She quite likes the idea. I told her I can create such an app in one month. And here we are, four months later, itemeter is officially live.

## Practical problem statement

_"Any household have a list of items to buy. Sooner or later, you will run out of some, and need to go to the supermarket to restock. It's not unusual that you just got home from a shopping trip, just to realise something else is running out soon. It's super annoying. Our brain is busy with many other things in life, and we just often forgot a little small thing. Stuffs just don't run out at the same time. But hey, if we can be well prepared with a little of efforts, maybe we won't never running out of things again."_

[itemeter](https://itemeter.com) is just another tiny and boring productivity app that hopes to help you achieve such small things. It's definitely not for everyone, but I think there is a small proportion of popullation that are in our shoes. I hope one day others (rather than just my wife and myself) also find it useful.

![](/website.png)

## Technical approach

I have built mobile apps using Swift and React Native in the past, this time I decided to try out Flutter. 
- For the simple nature of this app, I definitely don't need to go natively.
- I want to start with iOS first yet I need a piece of mind that I can easily make an Android version if I have a chance.
- I didn't like React Native and its ecosystem.

For cloud provider, I opted to go with AWS, which I am the most familiar with. I also chose the cheapest options possible.
- Cognito for Users management
- API Gateway + Lambda + DynamoDB for Backend
- S3/Cloudfront for the marketing website

## Costs

My AWS bills since I started this project is just $0.55 per month, which is for the domain hosting

![bill](https://github.com/namnd/namnd.github.io/assets/1306029/3e8b1160-5382-4b17-82b3-662c3e337655)

The primary cost for me is actually the Apple Developer membership, which is $149 AUD per year. The other significant one is $15 for the domain itemeter.com.
A total grand of **$174 AUD** for one year. I guess I can afford this for some fun.

## What's next?

This is more or less a fun side project. Learning Flutter was a fun experience. My wife and I will definitely be using the app for our shopping experience.

It would be nice to make some money off the app, enough to buy an Android phone, then build the Android version of the app.
I am not sure how to do that yet. I have no idea about marketing, sales, etc, and I dont plan to learn those things too.

I do have a few feature ideas for the app though. Maybe that would be my best next things to do.
