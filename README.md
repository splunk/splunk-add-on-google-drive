# Google Drive Add-On

## About

This add-on allows for indexing of metadata about Google Drive usage within an
organization. It captures audit events such as file creation, access, and
deletion.

It also serves as an example for using OAuth to authenticate a modular input.
More information can be found in Splunk's
[Developer Guidance](http://splunk.com/goto/oauthmodinput)

## Installing

To use this add-on, you must first create an project in the
[Google Developers Console](https://console.developers.google.com/project)

1. Create a new project, giving it whatever name suits your needs.
2. In your new project, click on `APIs & auth` -> `Credentials` in the nav bar.
3. Click the `Add credentials` button and select `OAuth 2.0 client ID`
4. Follow the prompt to create a product name for your consent screen
5. Select an `Application type` of `Other`, give it a name and press `Create`
6. Take note of your client ID and secret

Now set up the input in Splunk:

1. As an admin, go to the `Settings` menu and select `Data inputs`
2. In the `Google Drive Activity Stream` row, click `Add new`
3. Give your input a descriptive name and remember it, as we will need it when
   authorizing in the next step.
4. Click `More Settings`
    1. Set the interval to the rate at which you want to query Google Drive.
       86400 (24 hours) is a good value.
    2. Set the sourcetype to `google:drive:activity`
5. Save the configuration

Finally, we need to authorize the input. At the command line:

1. Ensure that the environment variable `$SPLUNK_HOME` is set to your Splunk
   installation directory
2. Run the following command (split into multiple lines for clarity):

    ```
    $SPLUNK_HOME/bin/splunk cmd python
        $SPLUNK_HOME/etc/apps/splunk-add-on-google-drive/bin/configure_oauth.py
        <input name> <client ID> <client secret>
    ```

    This will give you a URL that
    you can copy and past into a browser. Once you authenticate with your Google
    username and password you will get a key that you can then paste into the
    prompt.
3. Go back to the input you created above and disable and reenable it to kick
   off the modular input process immediately.
