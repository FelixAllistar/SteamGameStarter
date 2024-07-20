# Steam Game Starter
Starts games with a specific account. Just make a copy and edit the script to login to each account

This will only work if you have already logged into both accounts, clicked RememberMe on login box, and completed SteamGuard verification (where they email you a code). Once that is all done, this will let you launch a game with a specific steam username.

Works by modifying registry value of current user to set AutoLoginUser to whatever account you want. 
Instructions:
1. Download release
    Click SteamGameStarter.ps1 in files above <br/>
    On new page, click the 3 dots near top right, download file. <br/>
    ![alt text](image.png) <br/>

2. Right click > PROPERTIES <br/>
    Unblock [X]<br/> 
    ![alt text](image-8.png) <br/>

3. Right click > EDIT WITH NOTEPAD (should be at bottom)<br/>
    ![alt text](image-1.png) <br/>
    if not, use OPEN WITH... NOTEPAD but click "open with this ONCE" <br/>

4. Edit username and game id (currently set to dark and darker) <br/>
    gameID comes from the url of the steampage. numbers before the /GameName/. see the #note in script <br/>
    ![alt text](image-2.png) <br/>

5. Save & Close <br/>

6. Double left click > Open with powershell <br/>
    If thats not an option, search powershell in windows search. <br/>
    Right click it > show location.  <br/>
    ![alt text](image-3.png) <br/>
        if it takes you to a shortcut, right click the shortcut > show location. <br/>
    You should now be in powershell home(ex: C:\Windows\System32\WindowsPowerShell\v1.0).  <br/>
    Click the filepath at the top to highlight it and copy <br/>
    ![alt text](image-4.png) <br/>
    
    Double left click the SteamGameStarter.ps1 again  <br/>
    open with another program/choose another app.  <br/>
        (If this isnt working, try right clicking > open with...) <br/>
    Click Choose App from your pc (bottom) <br/>
    ![alt text](image-5.png) <br/>

    paste in the filepath at the top. <br/>
    ![alt text](image-6.png) <br/>
    select powershell.exe at the middle <br/>
    ![alt text](image-7.png) <br/>

    
7. Hit Always

