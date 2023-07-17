---
title: "A side hustle app"
date: 2023-07-16T13:38:12+10:00
tags: ["hustle", "mobile", "app", "ios", "flutter", "indie", "utilities", "shopping", "saving"]
---

For the last 4 months, I have been working on an mobile app. For a long time, I've been wanted to build something. This is not the first time I started something, yet finally this is the first one I actually make it to public, and I am pretty happy about it. This blog post is dedicated for this side hustle project, a boring mini mobile app, called **itemeter**.

## How it started

My family usually went shopping together since forever, but recently, when we had our second child, it's more often that we have to split the household duties. In particularly, one of us would go shopping with the older kid, while the other stays home and look after the younger one. We used to create the list of items to buy in the [Notes](https://apps.apple.com/us/app/notes/id1110145109) app, then share it with each other. It worked out pretty well. You can check off the item you bought. You can take photo, etc. However, Notes is more like a general Notes taking app. The UI hence is not really built for the shopping purpose. So, here's an idea. It's dead simple. It's a Notes taking app, but specialised for shopping purpose. It's also like a Todo list on steroid. My wife and I talked about it. She likes the idea. I told her I can make it in one month (of course, estimation is always wrong).

## Practical problem statement

_"Any household have a list of items to buy. Sooner or later, you will run out of some, and need to go to the supermarket to restock. It's not unusual that you just got home from a shopping trip, just to realise something else is running out soon. It's super annoying. Our brain is busy with many other things in life, and we just often forgot a little small thing. Stuffs just don't run out at the same time. But hey, if we can be well prepared with a little of efforts, maybe we won't never running out of things again."_

[itemeter](https://itemeter.com) is just another tiny and boring productivity app that hopes to help you achieve such small things. It's definitely not for everyone, but I think there is a small proportion of popullation that are in my shoes.

![](/website.png)

## Technical approach

Even though I built mobile apps using Swift and React Native in the past, this time I decided to try out Flutter. For the simple nature of this app, I definitely don't need to go natively. I also want to support both iOS and Android (coming soon). I didn't like React Native and its ecosystem. As a result, I chose Flutter. I have to say I had a great experience with Flutter.

For cloud provider, I opted to go with AWS, which I am pretty familiar with. I also chose the cheapest infrastructure/backend options. 
- Cognito for Users management
- API Gateway + Lambda + DynamoDB for Backend
- S3/Cloudfront for the marketing website

## Costs

My AWS bills since I started this project is just $0.55 per month, which is for the domain hosting

![bill](https://github.com/namnd/namnd.github.io/assets/1306029/3e8b1160-5382-4b17-82b3-662c3e337655)

The main cost includes
- $149 for Apple Developer membership
- $15 for the domain itemeter.com

A total grand of $174 AUD for one year. I think I can afford this.
