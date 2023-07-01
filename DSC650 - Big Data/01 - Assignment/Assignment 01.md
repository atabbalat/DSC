---
title: Assignment 1
subtitle: Computer performance, reliability, and scalability calculation
author: Abed Tabbalat
---

## 1.2 

#### a. Data Sizes

| Data Item                                  | Size per Item | 
|--------------------------------------------|--------------:|
| 128 character message.                     | 128 Bytes     |
| 1024x768 PNG image                         | 3.15 MB       |
| 1024x768 RAW image                         | 1.57 MB       | 
| HD (1080p) HEVC Video (15 minutes)         | 878.90 MB     |
| HD (1080p) Uncompressed Video (15 minutes) | 156,430 MB    |
| 4K UHD HEVC Video (15 minutes)             | 4,940 MB      |
| 4k UHD Uncompressed Video (15 minutes)     | 39,550 MB     |
| Human Genome (Uncompressed)                | 0.8 GB        |

##### Sources: Data Sizes
* Reference file: **Assignment_01_Calculations.ipynb**


#### b. Scaling

|                                           | Size          | # HD   | 
|-------------------------------------------|--------------:|-------:|
| Daily Twitter Tweets (Uncompressed)       | 0.064 TB      |    1   |
| Daily Twitter Tweets (Snappy Compressed)  | 0.043 TB      |    1   |
| Daily Instagram Photos                    | 236.25 TB     |   71   |
| Daily YouTube Videos                      | 632.81 TB     |  190   |
| Yearly Twitter Tweets (Uncompressed)      | 23.36 TB      |    8   |
| Yearly Twitter Tweets (Snappy Compressed) | 15.57 TB      |    5   |
| Yearly Instagram Photos                   | 86,231.25 TB  | 25,870 |
| Yearly YouTube Videos                     | 230,974.92 TB | 69,293 |

##### Sources: Scaling
* Reference file: **Assignment_01_Calculations.ipynb**


#### c. Reliability
|                                    | # HD         | # Failures |
|------------------------------------|-------------:|-----------:|
| Twitter Tweets (Uncompressed)      | 23.36 TB     |      1     |
| Twitter Tweets (Snappy Compressed) | 15.57 TB     |      1     |
| Instagram Photos                   | 86,231.25 TB |    355     |
| YouTube Videos                     | 230,974.92 TB|    950     |

##### Sources: Scaling
* Reference file: **Assignment_01_Calculations.ipynb**


#### d. Latency

|                           | One Way Latency      |
|---------------------------|---------------------:|
| Los Angeles to Amsterdam  |       44.67 ms       |
| Low Earth Orbit Satellite |        4.50 ms       |
| Geostationary Satellite   |      178.93 ms       |
| Earth to the Moon         |    1,922.00 ms       |
| Earth to Mars             |        6.94 minutes  | 

##### Sources: Latency
* Reference file: **Assignment_01_Calculations.ipynb**