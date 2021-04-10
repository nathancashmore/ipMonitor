![ip monitor logo](https://github.com/nathancashmore/ipMonitor/blob/master/ip-monitor-icon-small.png "IP Monitor Logo")
# IP Monitor
IP address monitor to identify ISP changes in a dynamic IP, update AWS with the change and notify on Slack

# Prerequisites

## OSX
- ```AWS cli``` - Used to update the DNS entry. See [AWS cli](https://aws.amazon.com/cli/).
- ```jq``` - To parse json responses.  See [jq downloads](https://stedolan.github.io/jq/download/).

## Windows
- ```AWS cli``` - Used to update the DNS entry. See [AWS cli](https://aws.amazon.com/cli/).
- ```jq``` - Best installed using [chocolatey](https://community.chocolatey.org/packages/jq#individual)
- ```GitBash``` - For a reasonable shell to run the script in with [cURL](https://curl.se/). See [Git for Windows](https://gitforwindows.org/)

> If running on windows worth creating a ```.bat``` file that runs the checkip.sh along with parameters
> placed inside this directory.  [TaskScheduler](https://docs.microsoft.com/en-us/windows/win32/taskschd/task-scheduler-start-page)
> can then be setup to run the ```.bat```.  Make sure its setup to run in this directory.

## Slack
Within your workspace in Slack create a new App for the IP Monitor.

- Create a Workspace on [Slack](https://www.slack.com) or login to your existing workspace.
- Create a new app at [api.slack.com](https://api.slack.com/apps)

> Once you have an app if you want there is a nice image called ```ip-monitor-icon.png``` in here you can use for it.
> That way it looks pretty when you get a notification.

# Usage

```
./checkip.sh [AWS_ZONE_ID] [SLACK_URL]
```
Where:

```AWS_ZONE_ID``` - Within [AWS Route 53 hosted zones](https://console.aws.amazon.com/route53/v2/hostedzones#) this is your Hosted zone ID e.g. ```Z36KQ5S2EXXXXX```

```SLACK_URL``` - Within [Your Apps in Slack](https://api.slack.com/apps) the full Webhook URL under Incomming Webhooks. e.g ```https://hooks.slack.com/services/T0H3CXXXX/B01SW7UXXXX/U3eGZZYWKRtLqPYOXhfxxxx```

