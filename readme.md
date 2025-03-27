# Docker Support for Meloday

This repository provides Docker support for [Meloday](https://github.com/trackstacker/meloday), a script that **automatically creates playlists throughout the day**, evolving with your listening habits. The Docker setup simplifies deployment and ensures a consistent runtime environment.

# Overview

Meloday is a script that **automatically creates playlists throughout the day**, evolving with your listening habits. Inspired by Spotify’s **daylist**, it pulls tracks from your **Plex listening history**, finds **patterns in what you like at different times**, and builds a mix that feels both **familiar and fresh**—without getting repetitive.

Each playlist update brings a **new cover, a new name, and a fresh mix of tracks** that fit the current moment. It also reaches into a **custom-built mood map** filled with different ways to describe the playlist’s vibe, so the names always stay interesting.

# What It Does

* **Creates playlists based on your past listening habits** – It looks at what you’ve played before at the same time of day.
* **Avoids repeats** – Tracks you’ve played too recently won’t be included.
* **Finds sonically similar tracks** – It expands your playlist with music that fits the vibe.
* **Uses Plex metadata, not AI** – Everything is based on your existing library and Plex’s own data.
* **Automatically updates itself** – No manual curation needed.
* **Applies custom covers and descriptions** – The playlist gets a new look each time it updates.
* **Gets creative with playlist names** – It pulls words from a mood map for extra variety.

# Docker Setup

## Prerequisites

* Docker installed on your system.
* A Plex Media Server with a music library.

## How to Use

1. Pull the Docker image from Docker Hub:
   ```bash
   docker pull cozza38/meloday
   ```

2. Run the container:
   ```bash
   docker run -d \
       -v /path/to/config:/config \
       cozza38/meloday
   ```

   Replace `/path/to/config` with the appropriate paths on your system.

3. Edit config.yml on your mounted volume

4. Restart the container

5. Check the logs to ensure the container is running correctly:
   ```bash
   docker logs <container_id>
   ```

# What It Doesn’t Do

* **It doesn’t add songs from outside your Plex library** – Everything comes from what you already have.
* **It doesn’t use AI recommendations** – There’s no external algorithm picking tracks, just your own listening history.
* **It doesn’t force specific genres or moods** – Your past listening shapes each playlist organically.
* **It doesn’t replace your other playlists** – This just runs alongside whatever else you have in Plex.

# How It Works

# 1. Identifies the Current Time Period

* Meloday divides the day into **morning, afternoon, evening, night, etc.**
* The script figures out the current time and selects the right time period.

# 2. Pulls Tracks from Your Listening History

* It looks at **what you’ve played at this time of day in the past**.
* If a track was **played too recently**, it’s skipped to keep things fresh.

# 3. Finds Sonically Similar Tracks

* It uses Plex’s **sonicallySimilar()** function to find related songs.
* This helps the playlist feel cohesive instead of just being a random shuffle.

# 4. Filters & Organizes Tracks

* **Duplicates** (live versions, remixes, etc.) are removed if they’re too similar.
* **Low-rated tracks** (anything with 1 or 2 stars) are skipped.
* **A mix of popular and rare tracks** is used so the playlist doesn’t feel repetitive.

# 5. Sorts the Playlist for a Natural Flow

* The **first track** is the earliest one you’ve played in that time period.
* The **last track** is the most recent one you’ve played in that time period.
* Everything in between is sorted by **sonic similarity** for smooth transitions.

# 6. Creates a Playlist Title & Description

Every playlist gets a **unique, descriptive name** based on what you’ve been listening to. Meloday doesn’t just pull from a basic list of moods—it taps into a **custom-built mood map** that expands common moods into more creative variations.

For example, if the playlist has a **cheerful vibe**, it won’t just call it "Cheerful." Instead, it might use words like:  Joyous, Sunny, Happy, Upbeat, or Jovial. Or, if it leans a bit more **quirky**, it might get a title with words like: Eccentric, Unconventional, Odd, or Whimsical.

This means **every playlist name feels different**, even if the mood stays similar, so maybe a *Brash Vibrant Lo-Fi Study Wednesday Evening* is in your future.

# 7. Applies a Cover & Updates the Playlist in Plex

* The cover image changes depending on the time of day.
* The script applies a **text overlay** to customize the cover.
* The playlist is updated with the new tracks, title, and description.

# Best Mileage

Meloday works best with **larger music libraries**. Since it pulls from **your own past listening**, the more variety you have, the better the playlists will be.

* If your **library is small**, Meloday might start repeating songs more often, creating a **feedback loop** where the same tracks show up frequently.
* If you **haven't rated your tracks**, it will still work, but if you take the time to rate songs (1-5 stars), Meloday will be able to **avoid low-rated content** and refine selections over time.
* Playlist generation *should* work for just about any size you make it, but a larger size will no doubt take longer to generate.
* Meloday was **tested on a library of only about 25,000 tracks**, so your mileage may vary on significantly smaller or larger collections.

# What’s Changed Since v2

* **Docker support added** – Simplified deployment with a Docker container.
* **Dynamic time period handling** – The script now reads time periods directly from the `config.yml` file.
* **Improved error handling** – Ensures smooth operation and better debugging.

# Who Made This?

This project was created by [trackstacker](https://github.com/trackstacker) with contributions from the community. If you’re enjoying Meloday and feel like saying thanks, [a coffee is always appreciated](https://buymeacoffee.com/trackstack). No pressure at all though, I just want people to enjoy it!
