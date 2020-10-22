####  Set up SignalFx SmartAgent on your host
:play_or_pause_button: **VIDEO:** [Full video demonstration of how to install the SignalFx SmartAgent and prep it for APM](https://drive.google.com/file/d/1nnPfryWY71LbT9vVn67BkXUkNEggcFnh/view?usp=sharing)  

Full docs are here: https://docs.signalfx.com/en/latest/integrations/agent/agent-install-methods.html  

Click on the Integrations Tab in your SignalFx account and follow instructions for SmartAgent- a complete setup script is ready with your token and realm and will set it up and run it automatically:  

[Link to the prefilled instructions directly in your SignalFx UI: https://app.signalfx.com/#/integrations?selectedKeyValue=custom:signalfx-agent&tab=Setup](https://app.signalfx.com/#/integrations?selectedKeyValue=custom:signalfx-agent&tab=Setup)

Or use the menus in the Splunk SignalFx web portal:  

<img src="../../../assets/smartagent.png" width="360" /> 

<img src="../../../assets/smartagentscript.png" width="360" />  

Once you deploy the SmartAgent on a host, you will see the host appear within seconds in the Infrastructure Tab in SignalFx.  
Check this and then move on to next step.

##### Configure SmartAgent for APM and restart it    

Reference docs are here: https://docs.signalfx.com/en/latest/apm/apm-getting-started/apm-smart-agent.html  

Edit `/etc/signalfx/agent.yaml` and update the stanzas below:

#1 If you are doing this Workshop as part of a group, add a unique hostname stanza:
`hostname: YOURUNIQUENAMEHERE`  

#2 Uncomment `defaultSpanTags:` and `environment`.  
Change `environment` to `sfx-workshop`.  
<ins>If you are doing this workshop as part of a group</ins> add a unique identifier to the `environment` name i.e. your initials `sfx-workshop-SJL`

The resulting stanza is:

```
  # If using SignalFx auto instrumentation with default settings
  - type: signalfx-forwarder
    listenAddress: 0.0.0.0:9080
    # Used to add a tag to spans missing it
    defaultSpanTags:
     environment: "sfx-workshop"
```

A premade reference for `/etc/signalfx/agent.yaml` is here: https://raw.githubusercontent.com/signalfx/apmworkshop/master/apm/agent/agent.yaml  

After updating your host with the supplied `agent.yaml` you can restart with `sudo service signalfx-agent restart`

[Return to workshop for next step](../README.md)
