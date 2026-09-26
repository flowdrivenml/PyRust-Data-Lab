# Kubuntu Plasma Customization

Kubuntu Plasma is fun to customize because the desktop is made of parts you can mix and match: colors, panels, icons, widgets, wallpaper, window decorations, and effects. I use Tokyo Night styling to give the desktop a consistent look, then add personal touches like animated wallpapers and Ghostty’s transparency.

## Quick Navigation

- [Why Customize Plasma](#why-customize-plasma)
- [Apply a Tokyo Night Look](#apply-a-tokyo-night-look)
- [Customize the Desktop](#customize-the-desktop)
- [Find Animated Wallpapers](#find-animated-wallpapers)
- [Find Still Wallpapers](#find-still-wallpapers)
- [Install an Animated Wallpaper](#install-an-animated-wallpaper)
- [Keep a Record of the Setup](#keep-a-record-of-the-setup)

## Why Customize Plasma

Plasma lets you shape the desktop around your taste and workflow instead of settling for the defaults. A coordinated dark theme makes the desktop feel more personal, while custom panels and widgets put the things you use most within reach. Animated wallpapers add atmosphere and movement; transparency can make apps like Ghostty blend into the desktop.

Most changes are available through **System Settings** or by right-clicking the desktop. You can try individual components and keep the parts you like. Plasma also lets you apply selected parts of a global theme, so changing colors does not have to replace your panel layout or other preferences. 

## Apply a Tokyo Night Look

Open **System Settings** from the application launcher and go to **Appearance & Style → Global Theme**. Look for a Tokyo Night theme, select it, and review which components it will change before applying it.

You can also tune the pieces separately under **Appearance & Style**: **Colors**, **Plasma Style**, **Icons**, **Cursors**, and **Window Decorations**. In **Colors**, select a Tokyo Night color scheme if you have installed one. Use **Get New…** where available to browse and install themes.

Useful places to browse:

- [KDE Store: Plasma themes](https://store.kde.org/browse?cat=104&ord=top)
- [KDE Plasma customization overview](https://kde.org/plasma-desktop/)

A theme may not include every component. If the desktop, icons, and window decorations do not all match after applying it, choose those pieces separately in **System Settings**. KDE describes both applying a global theme and changing its components individually. 

## Customize the Desktop

Right-click an empty area of the desktop and open **Configure Desktop and Wallpaper** to choose an image or adjust the desktop background. 
You can right-click a panel to enter edit mode, move or resize it, and add widgets. For other options, open **System Settings** and search by setting name; that is often quicker than browsing every category. 

## Find Animated Wallpapers

Animated wallpapers make the desktop feel more alive. Some are ready-to-use desktop integrations; others are video clips that you set as wallpaper through an app such as Hidamari.

Here are five places to explore:

- [Wallpaper Engine Workshop](https://steamcommunity.com/app/431960/workshop/) — a large community collection of animated wallpapers. Wallpaper Engine is a paid Steam app, and its Workshop is a fun place to discover creative scenes and animations.
- [KDE Store: Plasma 6 wallpaper plugins](https://store.kde.org/browse?cat=715) — Plasma add-ons, including wallpaper plugins. Check that a plugin supports your Plasma version.
- [Pixabay Videos](https://pixabay.com/videos/) — video clips that can be used as animated backgrounds.
- [Pexels Videos](https://www.pexels.com/videos/) — free stock footage; check the license for your intended use.
- [Mixkit Stock Video](https://mixkit.co/free-stock-video/) — HD and 4K clips, with license information on the site. 

**Steam note:** Wallpaper Engine’s Workshop content is designed for Wallpaper Engine. On Linux, using it with Plasma generally requires a community project or plugin, and compatibility can vary by Plasma version and wallpaper type. Check the installation instructions and current issues for the specific project before setting it up. One Plasma 6 community option is the [Wallpaper Engine for KDE project](https://github.com/RainyPixel/wallpaper-engine-kde-plugin).

If you want a simpler setup, download a video file from one of the video sites and set it as the background with Hidamari.

## Find Still Wallpapers

Still wallpapers are lighter on system resources and can look just as good. These five sites are useful starting points:

- [Wallhaven](https://wallhaven.cc/) — a large wallpaper collection with search and filters.
- [Unsplash Wallpapers](https://unsplash.com/wallpapers) — photography and desktop backgrounds.
- [Pexels Wallpapers](https://www.pexels.com/discover/wallpapers/) — downloadable wallpapers and photographs. 
- [Pixabay Wallpapers](https://pixabay.com/images/search/wallpaper/) — illustrations, photos, and backgrounds.
- [DeviantArt](https://www.deviantart.com/) — community-made digital art and wallpapers. Check the artist’s download and usage terms.

## Install an Animated Wallpaper

I use [Hidamari](https://github.com/jeffshee/hidamari) for animated wallpapers. Install it with Flatpak:

```bash
flatpak install flathub io.github.jeffshee.Hidamari
```

Open Hidamari from the application launcher, choose a video wallpaper, and set it as your desktop background. If the animation uses more system resources than you want, switch to a still image.

## Keep a Record of the Setup

Keep screenshots and notes in this `docs/` folder so you can recreate the look later. Useful screenshots include the desktop, the selected theme in System Settings, your panel layout, and Hidamari’s wallpaper view.

Plasma themes and settings can change between versions, so recording the choices you made is more useful than relying on a single collection of configuration files.
