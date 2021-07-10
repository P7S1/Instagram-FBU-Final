# Project 4 - *FBU Instagram*

**FBU Instagram** is a photo sharing app using Parse as its backend.

Time spent: **20** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User can sign up to create a new account using Parse authentication
- [x] User can log in and log out of his or her account
- [x] The current signed in user is persisted across app restarts
- [x] User can take a photo, add a caption, and post it to "Instagram"
- [x] User can view the last 20 posts submitted to "Instagram"
- [x] User can pull to refresh the last 20 posts submitted to "Instagram"
- [x] User can tap a post to view post details, including timestamp and caption.

The following **optional** features are implemented:

- [x] Run your app on your phone and use the camera to take the photo
- [ ] User can load more posts once he or she reaches the bottom of the feed using infinite scrolling.
- [x] Show the username and creation time for each post
- [x] User can use a Tab Bar to switch between a Home Feed tab (all posts) and a Profile tab (only posts published by the current user)
- User Profiles:
  - [x] Allow the logged in user to add a profile photo
  - [x] Display the profile photo with each post
  - [x] Tapping on a post's username or profile photo goes to that user's profile page
- [x] After the user submits a new post, show a progress HUD while the post is being uploaded to Parse
- [x] User can comment on a post and see all comments for each post in the post details screen.
- [x] User can like a post and see number of likes for each post in the post details screen.
- [x] Style the login page to look like the real Instagram login page.
- [x] Style the feed to look like the real Instagram feed.
- [ ] Implement a custom camera view.

The following **additional** features are implemented:

- [x] User can post videos in addition to photos
- [x] CollectionView of posts in profile
- [x] Custom date label(X hours, minutes, seconds, etc ago)  
- [x] Posts ImageView adjusts to the aspect ratio
- [x] Compress images with JPEG compression to preserve aspect ratio
- [x] Settings button changes from follow/settings depending if the profile is the current user
- [x] Videos are compressed to preserve storage space/bandwidth
- [x] Instagram Logo in navigation bar
- [x] When you tap a post on the profile collectionView, it opens a tableView with the other posts shown aswell     
- [x] View automatally animated up/down so the textViews aren't in the way of the keyboard
- [ ] Videos automatically play/pause
- [ ] Follow/Following
- [ ] Explore page

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. AVPlayer and using video
2. Complex queries with parse

## Video Walkthroughs

- [Video Player Posts](https://i.imgur.com/CrOJY3f.gif)
- [Liking/Commenting](https://i.imgur.com/TsC61rP.gif)
- [User persistance](https://i.imgur.com/zQhWNJ8.gif)
- [Sign In/ Register/ Log out](https://i.imgur.com/mKFC7k1.gif)
- [Posting via Camera](https://i.imgur.com/eGMU1u0.gif)
- [Liking/Details page/Comments](https://i.imgur.com/TzfxBIf.gif)
- [Posting Via photo picker](https://i.imgur.com/Axub9K3.gif)
- [Setting your Profile Picture](https://i.imgur.com/Bx0XTZ8.gif)






## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [Parse](https://github.com/parse-community/Parse-SDK-iOS-OSX) - Backend Library
- [IQKeyboardManager](https://github.com/hackiftekhar/IQKeyboardManager) - Keyboard Manager
- [SDWebImage](https://github.com/SDWebImage/SDWebImage) - Image fetcher/cache
- [SVProgressHUD](https://github.com/SVProgressHUD/SVProgressHUD) - Progress HUD


## Notes

- I tried to implement an auto-playing video feature similar to Instagram. However, due to time constraints I couldn't get it to work on time, so I settled to let the user manually play the videos with AVPlayerViewController. I learned from my mistakes from past projects and didn't waste a ton of time implementing only one feature.

## License

    Copyright [2021] [Atemnkeng Fontem]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
