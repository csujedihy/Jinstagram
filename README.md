# Project 6 - *Jinstagram*

**Jinstagram** is a photo sharing app using Parse as its backend.

Time spent: **19** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User can sign up to create a new account using Parse authentication
- [x] User can log in and log out of his or her account
- [x] The current signed in user is persisted across app restarts
- [x] User can take a photo, add a caption, and post it to "Instagram"
- [x] User can view the last 20 posts submitted to "Instagram"

The following **optional** features are implemented:

- [x] Show the username and creation time for each post
- [x] After the user submits a new post, show a progress HUD while the post is being uploaded to Parse.
- [x] User Profiles:
   - [x] Allow the logged in user to add a profile photo
   - [x] Display the profile photo with each post
   - [x] Tapping on a post's username or profile photo goes to that user's profile page

The following **additional** features are implemented:

- [x] Profile settings view which allows user to change avatar and update status- [x] Seamless update description and avatar image after changing them
- [x] Photo Model support cache and safe photo fetching which avoid setting to a recycled cell when network is lagging
- [x] Detail photo view

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. How Appdelegate initializes views and window?
2. Better improvement on Async loading in table view with operation cancellation

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

[http://i.imgur.com/CIAblHH.gif](http://i.imgur.com/CIAblHH.gif)

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.

## License

    Copyright [2016] [Yi Huang of copyright owner]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
