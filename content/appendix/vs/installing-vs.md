+++
title = "Installing Visual Studio"
weight = 10

pre = "<b>A2.1 </b>"
+++

## Installing Visual Studio

Visual Studio is available on the machines we use for CIS 300 labs, as well as on machines in other lab classrooms. This edition of Visual Studio is also freely available for installation on your own PC for your personal and classroom use. This section provides instructions for obtaining this software from Microsoft and installing it on your PC. The labs currently use Visual Studio 2022, though I encourage you to install the latest version available on your own machine (currently Visual Studio 2026).

{{% notice tip %}}

Visual Studio can also be accessed via a remote desktop server. However, this server can only be accessed either from on-campus or through the campus VPN.  See [https://www.k-state.edu/it/cybersecurity/vpn//](https://www.k-state.edu/it/cybersecurity/vpn//) for details on the campus VPN. For more details on the remote desktop server, see [the CS Department Support Wiki](https://support.cs.ksu.edu/CISDocs/wiki/Remote_Access#Remote_Windows_Access) (this page can be accessed only from on-campus or through the campus VPN).

The enterprise edition of Visual Studio is also available through the Azure Dev Tools for Teaching program. See [the CS Department Support Wiki](https://support.cs.ksu.edu/CISDocs/wiki/Azure_Dev_Tools_for_Teaching) (this page can be accessed only from on-campus or through the campus VPN) for details. A direct link to the Azure Dev Tools for Teaching portal is [https://azureforeducation.microsoft.com/devtools](https://azureforeducation.microsoft.com/devtools).

{{% /notice %}}

While Microsoft also produces a version of Visual Studio for Mac, we recommend the Windows version. If you don't have a Microsoft operating system, you can obtain one for free from the Azure Portal — see [the CS Department Support Wiki](https://support.cs.ksu.edu/CISDocs/wiki/FAQ#I_need_some_software_by_Microsoft_for_a_project.2C_can_you_give_it_to_me.3F) (accessible only from on-campus or through the campus VPN) for details.

You will need to install the operating system either on a separate bootable partition or using an emulator such as VMware Fusion. VMware Fusion is also available for free through the VMware Academic Program — see [the CS Department Support Wiki](https://support.cs.ksu.edu/CISDocs/wiki/FAQ#VMWare) for details. To download Visual Studio, go to [Microsoft's Visual Studio Site](https://visualstudio.microsoft.com/), and click the "Download Visual Studio" button. This should normally begin downloading an installation file; if not, click the "click here to retry" link near the top of the page. When the download has completed, run the file you downloaded. This will start the installation process.

As the installation is beginning, you will be shown a window asking for the components to be installed. Click the "Workloads" tab in this window, and select ".NET desktop development" (under "Desktop & Mobile"). You can select other workloads or components if you wish, but this workload will install all you need for CIS 300.

The first time you run Visual Studio, you will be asked to sign in to your Microsoft account. You can either do this or skip it by clicking, "Not now, maybe later." You will then be shown a window resembling the following:

<img src="VisualStudioSetup.png" alt="A picture of a configuration window should appear
here" style="zoom:67%;" />

Next to "Development Settings:", select "Visual C#". You can select whichever color scheme you prefer. At this point, Visual Studio should be fully installed and ready to use.