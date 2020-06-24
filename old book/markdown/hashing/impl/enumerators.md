# Enumerating a Hash Table

The .NET implementation of a dictionary includes two **public**
properties,
[**Keys**](http://msdn.microsoft.com/en-us/library/yt2fy5zk.aspx) and
[**Values**](http://msdn.microsoft.com/en-us/library/ekcfxy3x.aspx),
that can be used to obtain all the keys and values, respectively, in the
hash table. The data structures returned by these properties are
sub-types of
[**IEnumerable\<TKey\>**](http://msdn.microsoft.com/en-us/library/9eekhta0\(v=vs.110\).aspx)
and
[**IEnumerable\<TValue\>**](http://msdn.microsoft.com/en-us/library/9eekhta0\(v=vs.110\).aspx),
respectively, where **TKey** is the type of the keys and **TValue** is
the type of the values. Furthermore, the
**Dictionary\<TKey, TValue\>** class itself implements
**IEnumerable\<KeyValuePair\<TKey, TValue\>\>**. The
**IEnumerable\<T\>** interface allows the
[**foreach**](/~rhowell/DataStructures/redirect/foreach) statement to
iterate through the data structure - in the case of a dictionary, either
through the keys or the values or through the key-value pairs. In this
section, we will consider how to add this functionality. The
implementation we describe will be somewhat different from the .NET
implementation, which takes advantage of certain optimizations in the
implementation of the linked lists.

We will begin by discussing how to make the dictionary class itself
implement **IEnumerable\<KeyValuePair\<TKey, TValue\>\>**. We will
examine the details of the **IEnumerable\<T\>** interface shortly, but
for now, we will simply observe that it contains two methods, each of
which is responsible for returning an *enumerator*, which is an object
that can be used to step through a sequence of data elements. We make
this enumerator available by causing the dictionary to implement
**IEnumerable\<KeyValuePair\<TKey, TValue\>\>**. A **foreach** loop
can then iterate through the pairs that the supplied enumerator steps
through.

An enumerator is an object that is a subtype of the interface
[**IEnumerator\<T\>**](http://msdn.microsoft.com/en-us/library/78dfe2yb.aspx),
where **T** is the type of the objects in the sequence that the
enumerator is iterating through. Again, we'll examine the details of
this interface shortly, but first we will outline the general principles
of an enumerator. Within an enumerator, there is always a *current
position*. This current position is either one of the objects in the
sequence, or one of two special positions - the *start* position, which
occurs before any of the objects in the sequence, and the *end*
position, which occurs after all of the objects in the sequence.
Initially, an enumerator is in the start position. It is possible to
retrieve from the enumerator the object at the current position
(provided this is neither the start position nor the end position), or
to advance its current position to the next position in the sequence.

We need to define an enumerator that iterates through objects of type
**KeyValuePair\<TKey TValue\>**; i.e., we need to define a class that
implements **IEnumerator\<KeyValuePair\<TKey, TValue\>\>**. In order
to do this, we must place this definition where the compiler can
understand that **TKey** and **TValue** are type parameters to the
**Dictionary\<TKey, TValue\>** class. In order to accomplish this, we
need to define it as a *nested class* - a class whose definition occurs
within the definition of the **Dictionary\<TKey, TValue\>** class.
This nesting allows the nested class to access the private fields of any
instance of the containing class, as well as the type parameters to the
containing class. However, nesting classes does *not* nest instances of
the classes, or in any way automatically associate an instance of the
nested class with an instance of the containing class.

Let's now look at the details of an enumerator. The
[**IEnumerator\<T\>**](http://msdn.microsoft.com/en-us/library/78dfe2yb.aspx)
[interface](/~rhowell/DataStructures/redirect/interfaces) requires the
following members:

  - **public T Current**: This property gets the object at the current
    position. If the current position is either the start or the end, it
    throws an **InvalidOperationException**.

  - **public bool MoveNext()**: This method advances to the next
    position (unless it is already at the end) and returns whether the
    resulting position is a position prior to the end.

  - **object System.Collections.IEnumerator.Current**: This property is
    inherited from the non-generic
    [**IEnumerator**](http://msdn.microsoft.com/en-us/library/system.collections.ienumerator\(v=vs.110\).aspx)
    interface. Because it has the same name as the first property above,
    but has a different return type, an implementation of
    **IEnumerator\<T\>** must [explicitly
    implement](/~rhowell/DataStructures/redirect/explicit-impl) this
    property by omitting the **public** modifier and including the name
    of the **IEnumerator** interface in its name. Because it should
    behave in the same way as the **Current** property above, we can
    always write this method to simply return **Current**; i.e.,
    
        object System.Collections.IEnumerator.Current
        {
            get 
            {
                return Current;
            }
        }

  - **public void Dispose()**: This method should dispose of any
    [unmanaged
    resources](/~rhowell/DataStructures/redirect/unmanaged-resources).
    Often there are no unmanaged resources - in such cases, its body
    should be empty; i.e.:
    
        public void Dispose()
        {
        
        }

  - **public void Reset()**: This method was originally intended to
    reset the enumerator to the start position; however, it is no longer
    in use. Consequently, it can simply throw a
    **NotImplementedException**:
    
        public void Reset()
        {
            throw new NotImplementedException();
        }

In order to be able to implement the above members, the nested class
will need the following **private** fields:

  - The hash table to iterate through. This can either be a
    **Dictionary\<TKey, TValue\>** or an array of the type that
    implements the hash table. We will assume that it is an array, as
    this is the simplest approach.
  - The current index into the hash table. This is part of the
    information we need to keep track of the current position. We will
    use -1 to denote the start position and the length of the hash table
    to denote the end position; hence, this field should initially be
    set to -1.
  - The current linked list cell. This is the rest of the information we
    need to keep track of the current position. In order to simplify the
    code, we will assume this is initially a new linked list cell (i.e.,
    one that is not in the hash table). If we initialize this field in
    this way, it can always refer to a cell (i.e., it will not be
    **null**) until we reach the end position.

It will also need a constructor to initialize the first **private**
field above. This constructor will need a single parameter giving the
array that implements the hash table. Otherwise, because we will have no
unmanaged resources, we only need to focus on the **Current** property
and the **MoveNext** method.

Given the way we have defined the **private** fields, the implementation
of the **Current** property is fairly straightforward. We first need to
check to see if the current index is -1 or the length of the hash table
- if so, we need to throw an **InvalidOperationException**. Otherwise,
we can simply return the key-value pair in the current linked list cell.

The **MoveNext** method is a bit more involved. There is one simple case
- we are already at the end position (i.e., the current index is the
length of the hash table). In this case, we should just return
**false**. Otherwise, we need to advance the current cell to the next
cell in its list. This may, of course, cause the current cell to be
**null**. Because we want the current cell to remain non-**null** until
we reach the end position, we need to look for the next cell in the
table. We therefore need a loop that iterates as long as the current
cell is **null** (note that if it's already non-**null**, this loop
won't iterate at all). Each iteration of this loop needs to do the
following:

  - Increment the current index so that we are at the next linked list
    in the table.
  - If this takes us to the end position, return **false**.
  - Set the current cell to the beginning of the linked list at the
    current index.

Once the above loop terminates we can return **true**, as we have
reached the next cell in the hash table.

Once we have completed this nested class, we need to make the dictionary
class implement **IEnumerable\<KeyValuePair\<TKey, TValue\>\>**. The
**IEnumerable\<T\>** interface requires the following members:

  - **public IEnumerator\<T\> GetEnumerator()**: This method is used to
    get an enumerator.

  - **System.Collections.IEnumerator
    System.Collections.IEnumerable.GetEnumerator()**: This method is
    inherited from the non-generic
    [**IEnumerable**](http://msdn.microsoft.com/en-us/library/system.collections.ienumerable\(v=vs.110\).aspx)
    interface. Like the **System.Collections.IEnumerator.Current**
    property above, sub-types of **IEnumerable\<T\>** must explicitly
    implement this method because it returns a different type than the
    above **GetEnumerator** method. However, because
    **IEnumerator\<T\>** is a subtype of **IEnumerator**, this method
    can return the same enumerator as the above method; i.e., we can
    define it as:
    
        System.Collections.IEnumerator System.Collections.IEnumerable.GetEnumerator()
        {
            return GetEnumerator();
        }

The **GetEnumerator** method simply has to construct an instance of the
enumerator described above and return it.

We will now consider how to implement the **Keys** and **Values**
properties. We first need two additional classes to implement two more
enumerators. One must implement **IEnumerator\<TKey\>**, and the other
must implement **IEnumerator\<TValue\>**. Both of these classes must be
nested within the dictionary class. These classes are similar to the
nested class described above, but the **Current** property must now
return either the key or the value of the key-value pair.

Once we have these two enumerators defined, we need a way to access
them. This requires implementations of **IEnumerable\<TKey\>** and
**IEnumerable\<TValue\>**. The **Keys** and **Values** properties will
return instances of these classes, respectively. We therefore need to
define two more classes nested within the dictionary class. These
classes each need to be able to obtain an appropriate enumerator. In
order to be able to call the enumerator's constructor, each of these
classes must have access to an array implementing a hash table. Thus,
each of these classes needs such a **private** field and a constructor
to initialize it. Each **GetEnumerator** method will then construct an
instance of the appropriate enumerator and return it.

At this point, we can implement the **Keys** and **Values** properties
of the dictionary. Each of these properties simply needs to construct an
instance of the implementation of **IEnumerable\<TKey\>** or
**IEnumerable\<TValue\>**, respectively, and return it.
