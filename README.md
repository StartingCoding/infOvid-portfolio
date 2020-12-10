# ![icon](infOvid-readme-asset/icon.png)
# infOvid-portfolio

## What this app does

This is an app that let you stay up to date with the daily numbers of Covid cases in Italy.

![Italy View, Regions List View and Region Detail View of infOvid](infOvid-readme-asset/infOvid-screens.png)

## Why I built this app

When I found out that there wasn't any good mobile resources to see this important data, I built this app trying to solve my first real world problem.

[Link of Github with official JSON data](https://github.com/pcm-dpc/COVID-19)

![Italy and Regions Views From Website](infOvid-readme-asset/website-screens.png)

## How it is built

This app is built using MVVM and is made of:
- SwiftUI
  - TabView
  - NavigationView
  - List
- Combine
  - URLSession
  - JSONDecoder
- UserDefaults