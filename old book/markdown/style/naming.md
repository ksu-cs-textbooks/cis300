# Naming Conventions

The naming conventions described below use the following terminology:

  - **Pascal case:** Multiple words are joined without spaces, using
    capital letters at the beginning of each word. If acronyms of 3 or
    more letters are included, only the first letter of the acronym is
    capitalized. For example, AverageAge, ContextBoundObject, RgbCode.
  - **Camel case:** The same as pascal case, except the first letter is
    not capitalized. For example, averageAge, contextBoundObject,
    rgbCode.

### Namespaces

Use the form `Ksu.Cis300.ProgramName`, where each of the 3 components is
in pascal case. For the program name, use a name that tells what the
program does, not something like `Homework1`. For example:

    namespace Ksu.Cis300.Spreadsheet
    {
        . . .
    }

### Classes, Structures, and Enumerations

Use pascal case. If the name begins with "I", the following letter must
not be capitalized, as this would look like an interface - see below.
For an exception class, append the word "Exception". Make your names
descriptive nouns or noun phrases without abbreviations. For example:

    public class AccountManager
    {
        . . .
    }

### [Interfaces](../syntax/interfaces.html)

Use the above conventions with a capital "I" preceding the first letter
(which must also be capitalized). For example:

    public interface IPriorityQueue
    {
        . . .
    }

### Methods

Use pascal case. Make your names descriptive without abbreviations. For
example:

    private void InitializeComponent()
    {
        . . .
    }

Note that automatically-generated event handlers don't follow this
convention - this is an allowable exception to the rule. If you need to
write your own event handlers, follow the style of the automatically
generated ones.

### [Properties](../syntax/properties.html)

Use pascal case. Make your names descriptive without abbreviations. For
example:

    public bool IsEmpty
    {
        get
        {
           . . .
        }
    }

### Controls on Forms

Use camel case, and begin names with "ux" followed by a capital letter.
Make your names descriptive of the functionality, not the type of
control. For example, `uxAccept`, `uxCustomerName`. (You will not
typically declare these names in code, but will enter them in the Visual
Studio® design window.)

### Public [Constants](../syntax/const.html)

Use pascal case. Make your names descriptive. For example:

    public const double GravitationalAcceleration = 9.80665;

### Private Fields

Use camel case with an underscore character preceding the first letter.
For example:

    private double _weight;

### Parameters and Local Variables Within Methods

Use camel case. For example:

    public string ToMixedCase(string inString)
    {
        string outString;
        . . .
        return outString;
    }
