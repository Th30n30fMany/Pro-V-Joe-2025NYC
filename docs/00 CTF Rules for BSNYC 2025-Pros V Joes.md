**

# Pros V Joes CTF Rules for BSNYC 2025

Last update:  2025-10-06:7:45PM

Game Overview

The Pros V. Joes CTF provides players with a venue to practice their offensive and defensive Information Security skills in a hands-on, live-fire combat environment. Pros work with the Joes to teach them defensive skills and the art of offense in a multi-phase competition. The event is conducted in a private network, accessible only via a VPN (credentials required).

  

The spirit of this game can best be expressed in the 3 priorities of Pros V Joes.  These are, in order:

1. Learn
    
2. Have fun
    
3. Win if you can
    

  

A guiding principle:   
Don’t try to outrun the bear (aka, Red Team). Only try to outrun the other teams.

  

A Joe is a member of the Blue Team. Pros are members of either a Blue Team or a Red Team. Competition administrators are members of the Gold Team.

  

Teams of Joes compete against each other, each captained by one of their own team.  Pros V Joes Blue Pro Staff will aid and mentor all teams and their Joe Captains. These Teams defend themselves against the Pros on the Red Team.

  

During the course of the game, Gold Team will eventually announce that Blue Teams are authorized to conduct offensive activities against other Blue Teams. Red Team continues with their prior responsibilities, but Blue Teams can rent consulting hours from one Red Team member.

  

Blue Teams are responsible for the following

- Phase 1
    

- Maintaining control of their network of computer assets, which includes servers, clients, and firewalls
    
- Sustaining the highest uptime for Scored Services
    
- Defending their network of computer assets
    

- Phase 2
    

- All Phase 1 defensive responsibilities
    
- Attacking other Blue Teams’ networks to compromise systems
    
- Scorched Earth: The final phase of the game, where anything not expressly prohibited in the rules is fair game
    

- Prohibitions
    

- Players (including Red) may not render a host unreachable or unusable. This includes, but is not limited to
    

- Deleting files on a hard drive, such as to break the operating system or remote-access services (SSH, telnet, RDP, VNC, etc)
    
- Deactivating needed remote-access services (see above)
    

- Blocking remote access with firewalls or other ACL-type mechanisms
    
- NOTE - Some destructive behaviors are PROHIBITED even during Scorched Earth (the final combat phase of the game).  For a complete list, please see the Prohibited Actions 
    

  

Red Team is responsible for the following

- Phase 1
    

- Attacking and compromising all Blue Team networks (equally)
    
- Beaconing out from compromised systems to show control
    
- Increasing quantities of Red Team Joecoin
    

- Phase 2
    

- Attacking and compromising all Blue Team networks (equally)
    
- Beaconing out from compromised systems to show control
    
- Increasing quantities of Red Team Joecoin
    
- Supporting any Blue Team that purchases a given Red Team member’s time for consulting hours on directing offensive activities
    

  

Gold Team is responsible for the following

- Running the CTF environment and Scorebot
    
- Helping players with issues they may encounter
    
- Fixing technical issues that arise during the course of the game
    
- Scoring and declaring the winners
    
- Taking any actions deemed necessary and appropriate to manage the game, including making rule updates and enforcement decisions that aren’t documented within the rules
    

# Game Play

All about the flow of the game, what happens when, and what the responsibilities of each team are.

## Pre-Game

Before the start of the game, all players connect with their VPN clients.

Blue Team players log in to their assets and ensure they have control over all systems listed in their handouts. The Blue Team is currently prohibited from making any changes to its environment.

  

Red Team players confirm they have connectivity and can ping Blue Team networks.

The Gold Team prepares Scorebot, CTF Factory, and Storefront for gameplay, assists players experiencing difficulties, and resolves technical issues encountered during checkout.

## Game Time

When the Gold Team announces the start of the game, all authorized teams are free to attack and make any desired changes to their environments.

## Phase One

Within the given timeframe, Blue Teams are expected to maintain Scored Services, secure systems, and protect the network. Blue Teams are prohibited from any offensive actions.

  

Red Team is expected to compromise Blue Team assets, plant beacons, and increase their Joecoin account at the Blue Teams’ expense.  It should be noted that the Red Team receives early access to the environment, allowing them to better simulate real-world adversaries with extended dwell times.

  

Gold Team will monitor and maintain the gaming infrastructure to ensure continued play. The Gold Team will monitor all teams and players to ensure everything is going smoothly, providing assistance as necessary.

  

After at least or about 3 hours of gameplay, an intermediary, hot-wash light will be held between Blue & Red.  The amount of information given will be minimal, but this will serve as a checkpoint, as well as giving the Joes the opportunity to ask the Red Team questions (which they may or may not answer).  

  

At the end of Phase One, Blue Teams are prohibited from accessing or operating their networks until the start of Phase Two. Red Team is authorized to continue operations between Phases One and Two.

## Phase Two

Within the given amount of time, Blue Teams are expected to maintain Scored Services, secure systems, and protect the network, as well as their own flags. Services are expected to remain fully functional throughout the game. Blue Teams are also expected to attack the other Blue Teams networks, compromise their systems, and beacon to prove pwnership.

  

Gold Team will monitor and maintain the gaming infrastructure to ensure continued play. The Gold Team will monitor all teams and players to ensure everything is going smoothly, providing assistance as necessary.

## Post Game

At the end of the final Phase of the game, the Pro’s and the Joe’s will review what happened. Red Team members will reveal how they breached the Blue Team's environments, and all players will discuss better ways to defend against such attacks.  

  

This conversation is intended to be an open dialogue, with information sharing from both Red and Blue, for the learning and benefit of all.

  

During any hotwash meetings held throughout the game, the Red Team may, at their discretion, disclose information to the Blue Teams regarding their persistence mechanisms. Post-game hotwash consists of full disclosure.

# Scoring

## Blue Team

Blue Teams compete against each other for the highest number of points. Points are obtained by maintaining the scored services up and running.  See the Blue Team SOW for details.

## Red Team

Red Team members gain credit for compromising Blue Team assets.

  

Upon compromising assets, Red Team team members have the option to send beacons to Scorebot and prove pwnership. Different point values will be given for each beacon; the values of these will be disclosed to Red Team.  The Blue Team, whose asset is being beaconed from, will lose points for as long as the beacon continues to signal back to the Scorebot monitoring systems.

# CTF Economics

The Pros V Joes CTF includes an economic overlay to the game. What is that, you might be asking yourself? Well, let us explain.

  

In the real world, defenders and adversaries are both commonly limited by resources. It is not possible to deploy an infinite amount of defensive hardware and software, nor is it possible to devote an infinite amount of time to developing exploits and compromising a given host.

Points earned by Red and Blue can be exchanged for Joe Coins, which can be used to buy resources for the game.

  

This exchange and purchase system is achieved through a Gold Team-managed ZenCart that interfaces with Scorebot. Each team will have their own account in ZenCart to make purchases. The current exchange rate of points to coins will be advertised on the scoreboard. All transactions will be considered final and non-refundable.

  

The following examples of what might be in the store for purchase by Blue Teams include, but are not limited to:

- Threat intelligence on the Red Team
    
- Insurance against future (but not current or past) breaches
    
- Other goodies TBD
    

The following are examples of what might be in the store for purchase by Red Team, including, but not limited to:

- Credentials to Blue Team assets
    
- Knowledge of vulnerabilities in the Blue Team environments
    
- Access to Blue Team assets
    

Red Team will be authorized to add items to Zencart for sale to the Blue Teams. The following are examples of what this might include, but are not limited to:

- Surrender of a compromised asset back to the original Blue Team that originally owned it
    
- Flags that were stolen but not yet submitted to Scorebot for a penalty against the Blue Team in question
    

  

Using Additional Software During the Game

  

We encourage players to use methods and tools with which they’re comfortable. This game is about learning and having fun as you strive to keep services up and running better than the other Blue Teams. Gold Team will not limit the usage of any single-user software that players choose to bring and utilize on their personal devices. Teams may not bring or host servers or server applications via personal devices or cloud services (including SaaS). 

  

Any team that wishes to introduce additional software into the game environment must abide by the following process. Attempting or using additional software without following this process will result in a significant penalty in points, as determined by the Gold team.

  

1. Notify the Gold Team of the intent to introduce specialized software before its introduction. 
    
2. Acquire enough licenses of said software to provide to all teams, and provide all licenses to the Gold Team before the game starts. All licenses will be available for purchase through the Storefront during the game. Each team will pay a points fee if they wish to leverage the specialized software. Also, each team must install and configure said software on their own. Gold Team offers no guarantees regarding the successful functionality of this additional software. 
    

  
This process is intended to prevent a situation where any team may purchase their way to victory. 

# Game environment

The CTF gaming environment consists of a network for each Blue Team, with multiple servers and desktops running varying OS and services. Each Blue team has a dedicated firewall they can use to defend their network. Each Blue Team possesses and is in control of an authoritative DNS server that services their network to the rest of the Gaming Grid.

## Firewalls

The use of Firewalls comes with certain restrictions in this game, due to the nature of simulating real-world hacking adventures within a compressed time frame and without actual business users and benign traffic in the game environment. These rules cover both network and host firewalls, all protocols, and any alternative methods attempted to achieve the same effect through alternative means such as routing, DNS, or others.

  

Note the following definitions:

- Ingress - communications coming from the outside network into the defended network
    
- Egress - communications coming from the defended network into the outside network
    

The following rules must be followed at all times:

- Defensive Players may not restrict a host by any identifier, including IP address, netblock, hostname, or other means. This includes, but is not limited to, the following list: 
    

- Source blocking ingress communications from any address for any reason - all ingress rules must have an ANY field for source address
    
- Source allowing ingress communications from any address while blocking all other traffic
    
- Destination block egress communications to any address for any reason - all egress rules must have an ANY field for the destination IP address
    
- Destination allowing egress communications to any address while blocking all other traffic
    

Gold Team reserves the right to clarify or expand this definition during the course of the game as necessary.

- Firewalls must allow the following egress ports: 25/tcp, 80/tcp, 443/tcp, 53/udp
    
- All ingress rules must have egress counterparts that allow the opposite traffic flow.
    

- For example, if an ingress rule is applied to allow port 22/tcp initiated from the outside network connecting into the inside network, an egress rule must be applied to allow port 22/tcp initiated from the inside network connecting to the outside network
    

- Rules with ANY for BOTH the source and destination IP address are allowed, but not required
    

This is a section of rules where following the spirit of the law is far more important than following the letter of the law.  Attempts to rule lawyer will not be tolerated.  This game is meant for the players to learn, have fun, and to win if they can.  Please keep this in mind when using any firewall or ACL technology.

  

PROTIPS

- DNS is required for Scorebot to score your hosts
    
- ICMP is required for Scorebot to score your hosts
    
- Focus on locating Red persistence mechanisms on your defended hosts. Don’t spend cycles attempting to find creative ways to adhere to the letter of the firewall rules while violating its spirit by stopping all red traffic through network mitigations not explicitly spelled out here
    

## In-game Communications

Most in-game communications will occur either vocally or through the PvJ Slack.  Please be very attentive to attempts by the Gold Team to communicate announcements and/or changes.

### Changes

During the course of the game, the Gold Team reserves the right to deploy new assets for the Blue teams to defend against. The Blue Teams may or may not be notified of these changes during the course of play. Any such notifications may be sent out via one of the following means:

- in-game email
    
- Shouting
    
- Slack
    
- Morse code
    
- Carrier pigeon
    
- Dirty looks
    
- Semaphores
    
- Smoke signals (pending Fire Marshall approvals)
    
- ESP
    
- Spam texts to your cell phone
    

Blue Teams may request changes to their environment (e.g., new hosts) via any of the means listed above. If these messages are received, the Gold Team may or may not accomplish these tasks as time permits and may or may not update the Blue Team through the same means.

# Scorebot

Central to the game is the Scorebot scoring engine. This is a homegrown application that will track all aspects of the game and score players and teams accordingly.

During the game, Scorebot performs the following actions:

- Provides a total score for all Blue Teams
    
- Service scoring - Scorebot regularly monitors scored assets of each team throughout the game, following this process:
    

- DNS lookup - Scorebot will do a DNS lookup for each host against the Blue Team's own DNS server. If this check fails, the asset is marked unavailable, full points are docked, and Scorebot moves on
    
- Ping - After an IP address is acquired, Scorebot will send a ping to the host. If most of these pings fail, Scorebot will mark the asset as unavailable, and full points will be docked; Scorebot then moves on.
    
- Services - for each service, Scorebot does the following
    

- Connect to scored devices
    
- Defensive Players may NOT destination block outbound communications to any address for any reason
    

- Beacon receipt - Scorebot receives Red Team beacon transmissions from compromised assets within Blue Team networks.  
    

- For each beacon received in the allotted time interval, points will be deducted from the compromised Blue Team.  
    
- This facility is available to Blue Teams during their offensive activities in the Second Phase of the game, after Gold Team has declared the Purple phase and authorization for Blue offensive operations.
    

# Prohibited Actions

The following lists actions that are expressly prohibited at all times. Players violating these rules may be expelled from the game at the Gold Team’s discretion.

- ALL PHYSICAL LAYER ATTACKS ARE OUT OF SCOPE.  PERIOD.
    
- Players may NOT launch attacks targeting any assets that are outside of the Gaming Grid. This prohibition includes, but is not limited to
    

- Any Internet routable address is EXPRESSLY PROHIBITED
    
- Only the following addresses are targetable: 
    

- Aggregate: 100.80.0.0/21
    
- Teams:
    

- Athena 100.80.0.0/23
    
- BOREAS 100.80.2.0/23
    
- Charon 100.80.4.0/23
    
- DEMETER 100.80.6.0/23
    

- ALL OTHER TARGETS ARE PROHIBITED
    

- Blue Teams may not attack Red Team, though [modest Offensive Countermeasures](https://engage.mitre.org/matrix/) are acceptable.  The Gold Team reserves the right to deny any Blue countermeasure deemed to be in violation of the spirit of the rules.
    
- Players may not deploy self-propagating malware
    
- Players may not intentionally conduct denial of service attacks or cause denial of service as collateral damage to some other action.
    
- Players may not use a Blue Team’s firewall to completely lock them out of their environment.  Refer to the Firewall Rules section for more information.
    
- Defensive Players may not source block inbound communications from any address for any reason (See the Firewalls section for a more comprehensive list of limits for traffic blocking)
    
- Defensive Players may not destination block outbound communications to any address for any reason (See the Firewalls section for a more comprehensive list of limits for traffic blocking)
    

  

The following actions are expressly prohibited until Scorched Earth, the final combat phase of the game:

- No player (Red or Blue) may render a host unreachable or unusable. This includes, but is not limited to
    

- Deleting files on a hard drive such as to break the operating system or remote-access services (SSH, telnet, RDP, VNC, etc)
    
- Deactivating needed remote-access services (see above)
    

- Blocking remote access with firewalls or other ACL-type mechanisms
    

  

Tips to the Joes

Look to the Blue Pros for support. Additionally, here are a few helpful tips.

- Work as a team, collaborate constructively with your peers, Joes, and the Pros, who are there to help.  Previous years’ winners always made teamwork and preparation a top priority.
    
- If DNS doesn’t work, scoring doesn’t work.  Plan accordingly.
    
- Ensure that the required services are running and are as fully functional as they were when your team took possession of the asset.
    
- Many servers will come online and go offline throughout both game Phases. Don't overcommit to hardening a server; instead, attempt basic hardening followed by threat hunting.
    
- Ensure that new assets deployed are functioning correctly for their assigned services.  Gold Team makes no guarantee that newly deployed assets during the game will start green on Scorebot; some activity by Blue Teams may be required to achieve scoring for new assets.
    
- The single greatest loss of score for Blue Teams tends to be the loss of service availability.
    
- Ensure that the required applications are running
    
- Change Admin passwords on all devices (discover unknown accounts)
    
- Verify the accuracy of the provided documentation (including hidden servers, services, and accounts).
    
- Learn how to spot unusual and malicious behavior on the systems you’ll be defending.  The [MITRE ATT&CK Framework](https://attack.mitre.org/) is an excellent resource.
    
- Use what you know - bring your own system with familiar software (e.g., Event Log Explorer, Wireshark)
    
- Focus on the basics: Look for unsigned keys and software, auto-start processes, and other potential security risks. 
    
- Collect > Analyze > Escalate > Respond 
    
- Time management! Be aware of the clock as you do what needs doing
    
- Ask for help.  Collaborate with your teammates and captains.
    
- Try something new!
    
- Don’t lock yourself out - the firewall (network or host) can be your best friend or worst enemy!
    
- Check permissions (Is there a guest account with admin rights?)
    
- Check Shared files (“C:\” is shared to the world?!?)
    
- Get familiar with your systems (user accounts? suspicious software?)
    
- Communicate your findings to your team and seek help if needed.
    
- Know your people’s strengths!
    
- Google is your friend (well, not really, but search engines are useful…)
    
- Know your vulnerabilities - scan your own network
    
- Making a Major system change - get your captain's approval.
    
- Document everything you do and everything you find
    
- Protect what you write down (passwords/vulnerabilities)
    
- Research - Balance your time on researching and assigned tasks
    
- Remember - Red Team always wins. (The networks you defend are very, Very, VERY vulnerable...)
    
- There is not enough time to fix everything; this is an exercise in triage.
    
- Bring Stuff - Notepad/Laptop/Snack/Caffeine Drinks/Open Mind
    
- Take breaks. Rotate out for bio needs and mental downtime.  This is ESPECIALLY true with a marathon game format.
    

# Above all: Relax, have fun, and learn!

  
**