# Project 4 - *Twitter CLient*

**Twitter CLient** is a basic twitter app to read and compose tweets the [Twitter API](https://apps.twitter.com/).

Time spent: **12** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User can sign in using OAuth login flow
- [x] User can view last 20 tweets from their home timeline
- [x] The current signed in user will be persisted across restarts
- [x] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp.
- [x] Retweeting and favoriting should increment the retweet and favorite count.

The following **optional** features are implemented:

- [ ] User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client.
- [ ] User should be able to unretweet and unfavorite and should decrement the retweet and favorite count.
- [ ] User can pull to refresh.

The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Methods of better implementing favoriting and retweeting
2. Using NSDates

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='https://i.imgur.com/akFEITD.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

My primary challenge was getting the retweeting and favoriting to work. It still doesn't actually retweet or favorite, it only increments the local values. The functions to retweet and favorite are in TwitterClient.swift, but for some reason, they kept causing my app to crash. I finally ran out of time, but this will be the first thing I fix next week. Also, the time stamp doesn't display properly either, so I had it show a default value of 17 mins, although everything is set up to display it; I just need to figure out how to properly do so using the NSDate system. 

## License

    Copyright 2016 Cory Avra

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
