## WatchkitCurrency

Swift Currency Converter App for iWatch with generic scalable interface.

![Icon](http://injectionforxcode.johnholdsworth.com/convert4.gif) ![Icon](http://injectionforxcode.johnholdsworth.com/convert3.gif)

The user interface components in the initial release of Watchkit are
intentionally quite restricted due to the device's small size. There is
however enough flexibility using recursive WKInterfaceGroup elements to
to lay out interfaces pretty much at will with a little ingenuity.
Not something I'd recommend trying to do in your Watchkit App's 
storyboard mind you. Better to lay out your interface exactly how
you want in an iOS storyboard and generate the groups to insert
into the Watchkit storyboard programatically using the "Group.swift"
class in this project (See ViewController.swift in te main project.)

```
// here is where the grouping is done
var id: Int = 10
let iWatchAvailableArea38mm = CGRectMake(0.0, 0.0, 268.0, 302.0)
let iWatchAvailableArea42mm = CGRectMake(0.0, 0.0, 308.0, 352.0)
Group.group( self, frame:iWatchAvailableArea42mm,
    subviews:viewToGroup.subviews, id:&id, cg: cg )
```

The resulting hierarcy of groups for this currency convertor 
looks like this:

![Icon](http://injectionforxcode.johnholdsworth.com/frames2.png)

..and the storyboard xib snippet generated on the console. It uses
dimensions "Relative to the Container" so the interface scales 
according to whether the watch has a 38mm (268x302 pixels drawable)
or 42 mm display (308x352 pixels drawable).

```
<group alignment="left" height="0.0653409090909091" width="0.0" hasDetent="YES" id="GEN-10-GEN"><items/></group>
<group alignment="left" layout="horizontal" width="1.0" height="0.142045454545455" spacing="0.0" hasDetent="YES" id="GEN-11-GEN">
  <items>
    <group alignment="left" width="0.103896103896104" height="0.0" hasDetent="YES" id="GEN-12-GEN"><items/></group>
    <imageView alignment="left" width="0.795454545454545" height="1.0" id="GEN-13-GEN"/>
  </items>
</group>
<group alignment="left" height="0.0397727272727273" width="0.0" hasDetent="YES" id="GEN-14-GEN"><items/></group>
<group alignment="left" layout="horizontal" width="1.0" height="0.142045454545455" spacing="0.0" hasDetent="YES" id="GEN-15-GEN">
  <items>
    <group alignment="left" width="0.103896103896104" height="0.0" hasDetent="YES" id="GEN-16-GEN"><items/></group>
    <button alignment="left" width="0.162337662337662" height="1.0" backgroundImage="seven" id="GEN-17-GEN">
      <connections><action selector="seven:" destination="__TARGET__" id="GEN-18-GEN"/></connections>
    </button>
    <group alignment="left" width="0.0487012987012987" height="0.0" hasDetent="YES" id="GEN-19-GEN"><items/></group>
    <button alignment="left" width="0.162337662337662" height="1.0" backgroundImage="eight" id="GEN-20-GEN">
      <connections><action selector="eight:" destination="__TARGET__" id="GEN-21-GEN"/></connections>
    </button>
    <group alignment="left" width="0.0487012987012987" height="0.0" hasDetent="YES" id="GEN-22-GEN"><items/></group>
    <button alignment="left" width="0.162337662337662" height="1.0" backgroundImage="nine" id="GEN-23-GEN">
      <connections><action selector="nine:" destination="__TARGET__" id="GEN-24-GEN"/></connections>
    </button>
    <group alignment="left" width="0.0487012987012987" height="0.0" hasDetent="YES" id="GEN-25-GEN"><items/></group>
    <button alignment="left" width="0.162337662337662" height="1.0" backgroundImage="pound" id="GEN-26-GEN">
      <connections><action selector="pound:" destination="__TARGET__" id="GEN-27-GEN"/></connections>
    </button>
  </items>
</group>
<group alignment="left" height="0.0397727272727273" width="0.0" hasDetent="YES" id="GEN-28-GEN"><items/></group>
<group alignment="left" layout="horizontal" width="1.0" height="0.142045454545455" spacing="0.0" hasDetent="YES" id="GEN-29-GEN">
  <items>
    <group alignment="left" width="0.103896103896104" height="0.0" hasDetent="YES" id="GEN-30-GEN"><items/></group>
    <button alignment="left" width="0.162337662337662" height="1.0" backgroundImage="four" id="GEN-31-GEN">
…
```

You then manually edit this XML into the Watchkit target's Interface.storyboard 
by right-clicking on it and selecting  "Open As/Source Code". You can then 
insert this text inside a group or InterfaceController already on the interface. 
The iPhone interface template is at 2 times iWatch scale. If present action 
connections for buttons are preserved but you will need to replace the string
_ _ TARGET _ _ with the id of the InterfaceController in your storyboard.

The text output display is implemented by generating dynamic UIImages using
OpenGL CoreText in the Watch App extension running on the phone. These are then 
copied across to the watch and swapped onto the screen in a WKInterfaceImage.

### License

This code is made available under an MIT Style License. The backgrounds 
are from http://textures8.com/metal-and-iron-background-fifty-nine/ and
http://textures8.com/money-background-four/ licensed for personal use only.
