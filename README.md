# FiveM dynamic water demo

This resource demonstrates how to load and manipulate water at runtime within any running GTA5 FiveM server. This resource is more for educational purposes on how to dynamically load and manipulate water.

There are a few commands that can be ran with this resource.

- `loadwater` - Loads the custom water.xml
- `resetwater` - Resets water configuration to game defaults.
- `flood` - Simulates a rising water level flood.

![Flood / Tsunami](./flood.png)

### Overriding default water boundary for `water.xml`

The default water boundary is `minX: -4000, minY: -4000, maxX: 4500, maxY: 8000` this can be overriden, only reduced in size, by calling the following client native.

```lua
SetWaterAreaClipRect(-500, -500, 500, 500)
```

The maximum clip boundary of the entire map is `minX: -15999, minY: -15999, maxX: 15999, maxY: 15999`, although increasing the `SetWaterAreaClipRect` above what the default value is causes the game to crash! There is probably some other configurations that need updating to expand the scope of the water.xml bounds. More investigation is needed for this.

For players that are outside of these bounds, they will may see a gap within the map where the water level within the bounds are increasing and the water level outside of the bounds are remaining at 0.

### Quads

- `WaterQuad` defines the bounds, 2d vectors, in which water will be rendered. Since the bounds are 2-dimensional, you have limited control on the `z` axis, because much like the real world any open body of water is uniformally flat.
- `CalmingQuad` defines the bounds, 2d vectors, in which custom calming dampening can be applied. This takes priority over `WaveQuads`.
- `WaveQuad` defines the bounds, 2d vectors, in which "waves" can be configured with x/y direction and amplitude.

### Getting water.xml file

The `water.xml` file can be extracted with OpenIV. It is located within `common.rpf -> data -> levels -> gta5 -> water.xml`, simply open and copy the contents, or extract to a known path within your system.

This represents most, not all, of the water within the map. Known exceptions include Vespucci Canals, Zancudo River, Cassidy Creek, Los Santos River.

### Setting WaterQuad Elevation (z)

You can override the default elevation, above ground level (z) for each WaterQuad independently. This can be configured by modifying the following attribute within the desired WaterQuad.

```xml
  <WaterQuads>
    <Item>
      ...
      <z value="20.0" />
    </Item>
  </WaterQuads>
```

The above example will configure a WaterQuad to have its elevation, 20 units above ground level.

### Setting WaterQuad Depth

By defaul each WaterQuad will have water to the bottom of the map. In cases where you want to limit the depth (-z) where the water will stop you can configure it with the `HasLimitedDepth` and `LimitedDepth` attributes.

```xml
  <WaterQuads>
    <Item>
      ...
      <HasLimitedDepth value="true" />
      <LimitedDepth value="10" />
      <z value="20.0" />
    </Item>
  </WaterQuads>
```

The example above will create a WaterQuad with height boundary of `minZ: 10, maxZ: 20`.

### Reset to default water.xml

To reset to the games default water.xml configuration you can simply invoke the [client side native](https://docs.fivem.net/natives/?_0x1DA4791) `ResetWater()`.

### Notes

The code in this repository represents the same "flooding" / "tsunami" which was demonstrated by [Nikez](https://github.com/nikez) in this video, and is probably the same approach used for flooding the sewers / tunnels in NoPixel 4.0

[![Flooding Tsunami](https://img.youtube.com/vi/dGXQkuVDe7g/sddefault.jpg)](https://www.youtube.com/watch?v=dGXQkuVDe7g)

### References

While somewhat outdated the following are good resources of information for water.xml

- https://www.alebalweb-blog.com/22-tutorial-add-modify-water-in-gta-5-water-xml.html
