+++
title = "Visual Studio Solutions"
weight = 30

pre = "<b>A2.3. </b>"
+++

## Visual Studio Solutions

All code developed within Visual Studio 2022 must belong to one or more *solutions*. When you are using Visual Studio to develop a program, you will be working with a single solution. A solution will contain one or more *projects*. Each of these projects may belong to more than one solution. Each project typically contains several files, including source code files. Each file will typically belong to only one project. The following figure illustrates some of the possible relationships between solutions, projects, and files.

![Relationships between solutions, projects, and files](solutions.jpg)

Note that in the above figure, Project4 is contained in both Solution2 and Solution3. In this section, we will focus on solutions that contain exactly one project, which in turn belongs to no other solutions (e.g., Solution1 in the above figure).

Whenever you open a solution in Studio 2022, the Solution Explorer
(which you can always find on the "View" menu) will give you a view of
the structure of your solution; for example, opening the solution in
the repository given in [the previous section](/appendix/vs/repos/) may result in the
following being shown in the Solution Explorer:

<img src="initial-solution-explorer.jpg" alt="A picture of a Solution Explorer should appear here" style="zoom:67%;" />

If you see the above, you will need to change to the Solution view, which you can get by double clicking the line that ends in ".sln". This will give you the following view:

<img src="solution-explorer1.png" alt="A picture of a Solution Explorer should appear
here" style="zoom:67%;" />

{{% notice warning %}}

You ordinarily will not want to use Folder view, as this will cause files to be edited without any syntax or consistency checking. As a result, you can end up with a solution that is unusable. If your Solution Explorer ever looks like this:

<img src="folder-view1.png" alt="A picture of a Solution Explorer in folder view should appear here" style="zoom:60%;" />

(note the indication "Folder View" at the top and the absence of any boldface line), then it is in Folder view. To return to Solution view, click the icon indicated by the arrow in the above figure. This will return the Solution Explorer to the initial view shown above, where you can double-click the solution to select Solution view.

{{% /notice %}}

If you click on the small triangle to the left of
"Ksu.Cis300.HelloWorld", you will get a more-detailed view:

<img src="solution-explorer2.png" alt="A picture of a Solution Explorer should appear here" style="zoom:67%;" />

Near the top, just under the search box, is the name of the solution with an indication of how many projects it contains. Listed under the name of the solution is each project, together with the various components of the project. One of the projects is always shown in bold face. The bold face indicates that this project is the startup project; i.e., it is the project that the debugger will attempt to execute whenever it is invoked (for more details, see the section, ["The Debugger"](/appendix/vs/debugger)).

The project components having a suffix of ".cs" are C\# source code files. When a Windows Forms App is created, its project will contain the following three source code files:

- **Form1.cs:** This file contains code that you will write in order to implement the main GUI for the application. It will be discussed in more detail in ["The Code Window"](/appendix/vs/code-window).

- **Form1.Designer.cs:** You will need to click the triangle to the
  left of "Form1.cs" in the Solution Explorer in order to reveal this
  file name. This contains automatically-generated code that completes
  the definition of the main GUI. You will build this code indirectly
  by laying out the graphical components of the GUI in the design window (see the section, ["The Design Window"](/appendix/vs/design-window) for more details). Ordinarily, you will not need to look at the contents of this file.

- **Program.cs:** This file will contain something like the following:
  ```C#
  namespace Ksu.Cis300.HelloWorld
  {
      internal static class Program
      {
          /// <summary>
          ///  The main entry point for the application.
          /// </summary>
          [STAThread]
          static void Main()
          {
              // To customize application configuration such as set high DPI settings or default font,
              // see https://aka.ms/applicationconfiguration.
              ApplicationConfiguration.Initialize();
              Application.Run(new Form1());
          }
      }
  }
  ```
  
  The **Main** method is where the application code begins. The last line of this method constructs a new instance of the class that implements the GUI. The call to [**Application.Run**](https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.application.run?view=windowsdesktop-6.0) displays the GUI and starts a loop that processes events such as mouse clicks and keystrokes. Ordinarily, there is no need to look at this code.

One of the first things you will need to do when starting a new Windows Forms App is to change the name of Form1.cs, as this name (without the ".cs" suffix) is also the name of the class implementing the GUI. Therefore, it will need to be changed in order to conform to the [naming convention](/appendix/style/naming) for classes. To do this, right-click on its name in the Solution Explorer, and select "Rename" from the resulting popup menu. You will then be able to edit the name in the Solution Explorer - change it to "UserInterface.cs". When you have entered the new name, the following window will be displayed:

<img src="rename-prompt.jpg" alt="The prompt to rename all occurrences of a file name." style="zoom:67%;" />

You should click the "Yes" button in order to make the renaming consistent - particularly to rename the class as well.
