## WatchkitCurrency

Swift Currency Converter App for iWatch with generic scalable interface.

![Icon](http://injectionforxcode.johnholdsworth.com/convert4.gif) ![Icon](http://injectionforxcode.johnholdsworth.com/convert3.gif)

The user interface components in the initial release of Watchkit are
intentionally quite restricted due to the devices small size. There is
however enough flexibility using recursive WKInterfaceGroup elements to
to lay out interfaces pretty much at will with a little ingenuity.
Not something I'd recommend trying to do in your Watchkit App's 
storyboard mind you. Better to lay out your interface exactly how
you want in an iOS storyboard and generate the groups to insert
into the storyboard programatically using the "Group.swift" class in this
project. The resulting hierarcy of groups for this currency convertor
looks like this:

![Icon](http://injectionforxcode.johnholdsworth.com/frames2.png)

And the storyboard xib snippet generated is the console. It uses
dimensions "Relative to the Container" so the interface scales 
according to whether the watch has a 38mm (268x302 pixels drawable)
or 42 mm display (308x352 pixels drawable).

```
<group alignment="center" layout="vertical" width="1.0" height="1.0" spacing="0.0" hasDetent="YES" id="GEN-10-GEN">
  <items>
    <group height="0.0653409090909091" width="0.0" alignment="left" hasDetent="YES" id="GEN-11-GEN"><items/></group>
    <group alignment="center" layout="horizontal" width="1.0" height="0.142045454545455" spacing="0.0" hasDetent="YES" id="GEN-12-GEN">
      <items>
        <group width="0.103896103896104" height="0.0" alignment="left" hasDetent="YES" id="GEN-13-GEN"><items/></group>
        <imageView alignment="left" width="0.795454545454545" height="1.0" id="GEN-14-GEN"/>
      </items>
    </group>
    <group height="0.0397727272727273" width="0.0" alignment="left" hasDetent="YES" id="GEN-15-GEN"><items/></group>
    <group alignment="center" layout="horizontal" width="1.0" height="0.142045454545455" spacing="0.0" hasDetent="YES" id="GEN-16-GEN">
      <items>
        <group width="0.103896103896104" height="0.0" alignment="left" hasDetent="YES" id="GEN-17-GEN"><items/></group>
        <group alignment="left" width="0.162337662337662" height="1.0" backgroundImage="seven" id="GEN-18-GEN">
          <items>
            <button alignment="left" title="7" width="1.0" height="1.0" alpha="0.05" id="GEN-19-GEN">
              <connections><action selector="seven:" destination="__TARGET__" id="GEN-20-GEN"/></connections>
            </button>
          </items>
        </group>
        <group width="0.0487012987012987" height="0.0" alignment="left" hasDetent="YES" id="GEN-21-GEN"><items/></group>
        <group alignment="left" width="0.162337662337662" height="1.0" backgroundImage="eight" id="GEN-22-GEN">
          <items>
            <button alignment="left" title="8" width="1.0" height="1.0" alpha="0.05" id="GEN-23-GEN">
              <connections><action selector="eight:" destination="__TARGET__" id="GEN-24-GEN"/></connections>
            </button>
          </items>
        </group>
        <group width="0.0487012987012987" height="0.0" alignment="left" hasDetent="YES" id="GEN-25-GEN"><items/></group>
        <group alignment="left" width="0.162337662337662" height="1.0" backgroundImage="nine" id="GEN-26-GEN">
          <items>
            <button alignment="left" title="9" width="1.0" height="1.0" alpha="0.05" id="GEN-27-GEN">
              <connections><action selector="nine:" destination="__TARGET__" id="GEN-28-GEN"/></connections>
            </button>
          </items>
…
```

This XML is then manually edited into the Watchkit 
target's Interface.storyboard by right-clicking on it and selecting 
"Open As/Source Code". You can then insert this text inside a group already 
on the interface. The iphone interface template is at 2 times iWatch scale.

In the generated storyboard snippet, buttons are implemented using
a surrounding group which provides the image for the button as it's
background image (the name of the image take from it's action selector.) 
A button press is simulated by toggling this image. Inside the group, 
the actual WKInterfaceButton has an alpha of 0.05 so it doesn't display 
but still accepts tap events inside it's bounds. If present action
connections are preserved but you will need to replace the string 
__TARGET__ with the id of the InterfaceController in your soryboard.

The text output display is implemented by generating dynamic UIImages using
OpenGL in the Watch App extension running on the phone. These are then 
copied across to the watch and swapped onto the screen in a WKInterfaceImage.

### License

This code is made available under an MIT Style License. The background 
is from http://textures8.com/metal-and-iron-background-fifty-nine/
licensed for personal use only.
