---
title: "A side hustle app"
date: 2023-05-08T13:38:12+10:00
draft: true
tags: ["hustle", "mobile", "app", "ios", "flutter", "indie"]
---

## The idea

The idea is dead simple. 

_"Any household have a list of items to buy. Sooner or later, you will run out of some, and need to go to the supermarket to restock. It's not unusual (or at least happened to me a dozen of times) is that you just got home from a trip to shopping mall, just to realise something else is running out soon. It's super annoying. Our brain is busy with many other things in life, and we just often forgot a little small thing. Stuffs just don't run out at the same time. But hey, if we know how much left, we can be well prepared and almost never running out of things."_

This [itemeter](https://itemeter.com) app is just another tiny productivity app that hopes to help you achive such small things, but sometime can make a big difference.

![](/website.png)

## But why
There are probably many similar apps out there that can be used for this purpose. A simple Todo app will do 70% of the job. The Notes app by Apple almost got you cover too. So, why another one. Well, for a couple of reasons:
- I couldn't find exact app that fulfill my requirements. Sometime, family cannot go shopping together. I don't know some of stuff my wife need, and vice versa. By sharing the list for all members of the family, it makes things much easier.
- My wife and I will definitely be using this app. We find it really useful, so why not share it with many other families for (hopefully) a small revenue from it.
- It's a side hustle thing. I am not an indie hacker nor a startup guy, but the idea is so simple to start with, so I guess I can just spend a couple of weeks to build it. Of course, it took much longer than that, but I had a great time hacking to ship this thing.


## Tech stacks

I built mobile apps using Swift and React Native in the past. This is my first time trying Flutter. For now, I am only releasing iOS app. If this goes well (hopefully), I might publish the Android version as well.

For cloud provider, I opted to go with AWS. It's really simple and cheap solution.
- Cognito for Users management
- API Gateway + Lambda + DynamoDB for Backend
- S3/Cloudfront for the marketing website

## Costs

- $149 for Apple Developer membership
- $15 for domain itemeter.com
- $0.82 per month, projected $10 per year

A total grand of $174 AUD for one year. I think I can afford this.
