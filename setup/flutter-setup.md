## App Development Tools Installation Steps

Choose your desired **IDE** tool for developing mobile Apps from the below options.
1. Android Studio
2. IntelliJ idea
3. Vs Code

Find the download links for the above **IDE** tools.

<span style="color: #4b7d2f; font-size: 15pt">1. Android Studio </span> - [https://developer.android.com/studio]() </br> 
Download the Android Studio software by clicking on the <span style="color: #4b7d2f; font-size: 12pt; font-weight: bold">Download Android Studio</span>

<span style="color: #17202A; font-size: 15pt">2. IntelliJ idea </span> - [https://www.jetbrains.com/idea/download]() </br>
Download the IntelliJ idea software by selecting your respective Operating System running on your laptop/computer (Choose download Option under **Community** section)

<span style="color: #373277; font-size: 15pt">3. Vs Code </span> - [https://code.visualstudio.com/]() </br>
Download the stable build version software from the official website based on your Operating system on your laptop/computer.

After installing the respective tools, install the below given plugins from the **Settings Repository** after successful installation of those software's.
</br><span style="color: #e67300; font-size: 13pt">For example:</span> Installing plugins in **Android Studio** from settings page. Follow the below images to install plugins</br></br>
Installing flutter plugin (Click on **Browse repositories** option and search for **Flutter**)</br>
<img src="https://i.stack.imgur.com/D3Lrd.png" width="800" height="500" /></br></br>
Installing dart plugin (Click on **Browse repositories** option and search for **Dart**, you can find under languages category)
<img src="https://user-images.githubusercontent.com/3614291/30086432-0acb906e-9269-11e7-8ae3-b2caca9fba16.png" width="900" height="600" />
### Flutter SDK Setup

Follow the below steps to download and setup the **Flutter SDK** to start developing the Apps.

1. Basically, flutter will support **3 different Operating systems** support to develop mobile Apps using ***flutter***.</br>
a. **Mac Operating System**: Open this link [https://flutter.dev/docs/get-started/install/macos]() and download the installation bundle file</br>   - Move the folder to  your desired location and unzip the file, you will get one folder in the name of **flutter**</br>- Open **terminal** and enter the below commands to setup the **flutter sdk** file path</br>
b. **Windows Operating System**: Open command prompt and navigate to your desired folder location and paste the given command **[git clone -b stable https://github.com/flutter/flutter.git]()** to download the **Flutter SDK** from the official **GIT** repository, directly to your new created sdk location. After that follow the below steps.
- ```cd /home-path (just replace the home-path with your laptop users home path)```
- ```sudo nano .bash_profile (remember there is space between each word)```
- ```Enter the command ```(**export PATH=$PATH:/HNB_Project/flutter_sdk/flutter/bin:$PATH**)``` by replacing the existing flutter sdk path from the command with your local flutter sdk file location. Add the flutter sdk file location between $PATH:  :$PATH```
- ```Then press shift+: wq to save and exit the file```
- ```echo $PATH``` to check whether the given **flutter** path has been set or not
- Then run **flutter doctor** command to verify the successful installtion of flutter SDK and the completion of SDK setup to your IDE.

After completing the above steps, **Mac** users needs to complete the below commands after installing the **Xcode** software from **App Store**.</br>
>Install homebrew - paste the below command in terminal </br>**/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"**</br>
> brew install --HEAD usbmuxd</br>
> brew link usbmuxd</br>
> brew install --HEAD libimobiledevice</br>
> brew install ideviceinstaller ios-deploy cocoapods</br>
> pod setup
Complete all the above commands, without failure to complete the setup to get the **flutter** support for Xcode to deploy Apps on iOS devices.</br>
</br>c. **Linux Operating System**: Please follow the instructions from the official developer website [https://flutter.dev/docs/get-started/install/linux]()
