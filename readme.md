# Docker Support for Meloday

This repository provides Docker support for [Meloday](https://github.com/trackstacker/meloday), a script that **automatically creates playlists throughout the day**, evolving with your listening habits. The Docker setup simplifies deployment and ensures a consistent runtime environment.

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

# Who Made This?

This project was created by [trackstacker](https://github.com/trackstacker) with contributions from the community. If you’re enjoying Meloday and feel like saying thanks, [a coffee is always appreciated](https://buymeacoffee.com/trackstack). No pressure at all though, I just want people to enjoy it!
