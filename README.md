# shadersfromscratch
Experimenting with Surface Shaders (mainly) as part of a couple of tutorials and courses. List of all the generated shaders you can find in Assets/Shaders folder, each one including an image/video demoing the effect.

* <span></span>**1. Emission Albedo:** Very simple shader that shades the geometry based on the albedo and emission colors given as parameter

   <img src="https://user-images.githubusercontent.com/5633645/33520423-5bb4c3e0-d799-11e7-9b00-8f5d1222b9d5.png" alt="scene1to7_2" style="max-width:100%" width="256" heigth="256">
   
* <span></span>**2. Emission Albedo Normal** Very simple shader that shades the geometry based on the albedo and emission colors passed as parameter. It also sets the geometry normals based on an additional color parameter

* <span></span>**3. Skybox Reflection:** Shades the object with a given diffuse texture plus a given cube map to set the emission based on the reflection vector for each pixel, generating a reflection effect. If the geometry is flat shaded it should behave as a perfect mirror (no interpolation of the reflection vector before sampling the cube map)

* <span></span>**4. Skybox Reflection Albedo:** Shades the object with a given diffuse texture plus a given cube map to set the emission based on the reflection vector for each pixel, generating a reflection effect. If the geometry is flat shaded it should behave as a perfect mirror (no interpolation of the reflection vector before sampling the cube map). In contrast with previous shader it also accepts a color to compose with the reflective one.

* <span></span>**5. Full Green:** Takes a texture to use as the albedo colour and just turns up the green channel to full

* <span></span>**6. Green Texture:** Quite similar to the previous shader but composes the given texture with a gree color

* <span></span>**7. Emission Albedo Texture:** Shades the geometry with a given albedo texture as well as an emmision texture

* <span></span>**8. Diffuse Normal:** Shades the geometry with a given albedo texture and a normal map, which bumpinness is driven by another parameter

* <span></span>**9. Diffuse Normal Intensity:** Shades the geometry with a given albedo texture and a normal map, which bumpinness is driven by another parameter. It also includes an additional parameter to turn the brightness over the geometry up and down

* <span></span>**11. Snow:** Shades the geometry with a given texture and color adding an effect so part of the geometry gets whitened as it was snow. The direction, color and amount of snow is configurable through a couple of input parameters

* <span></span>**14. Normal Scaler:** Shades the geometry with white color but sets the normal with the given parameters so to affect the way the light is calculated

* <span></span>**15. Normal Visualizer:** Shades the geometry with the normal vector used as a color, modified to control the amount of bump (X and Y coords) and the intensity/length (Z coord)

* <span></span>**16. Skybox Reflection Bump:** This shader is a combination of 4 and 9, so it includes reflection based on a cubemap as well as bump mapping based on a given normal map and a few parameters settings (intensity of bump, bump amount, etc)

* <span></span>**17. Metallic Reflective Bump:** Shades the geometry with a metallic reflective bump mapped material. Takes a normal map and a cube map. The normal map is unwrapped onto the surface normals and multiplied by a fixed factor. The cube map is used to set the Albedo.

* <span></span>**18. Dot Product Albedo:** Shades the geometry based on the angle between the normals and the view direction (used to set the color's red channel). It uses a color displacement parameter to allowing to invert the shading

* <span></span>**19. Rim:** Creates a Rim effect highlighting just the borders of the geomtry with the given color and intensity parameters

* <span></span>**20. Hard Rim:** Creates a Rim effect highlighting just the borders of the geometry with the given color and intensity parameters, considering also a threshold used to control the start of the Rim area

* <span></span>**21. Rim Bands:** Creates a Rim effect highlighting just the borders of the geomtry with the given colors and intensity parameters. The color thresholds allow to configure the size of the color bands

* <span></span>**22. Stripes:** Shades the geometry by interchanging two colors depending on the world position, giving a multicolor horizontal band effect as a result

* <span></span>**23. Striped Rim:** Shades the geometry by interchanging two colors depending on the world position, giving a multicolor horizontal band effect as a result. The band is rimmed to the edges depending on the given threshold parameter.

* <span></span>**24. Textured Striped Rim:** Shades the geometry with a base texture in addition to interchanging two colors depending on the world position, giving a multicolor horizontal band effect as a result. The band is rimmed to the edges depending on the given threshold parameter, and the size of each band is also configurable

* <span></span>**25. Basic Blinn Phong:** Shades the geometry with speculear Blinn Phong lighting based on the input parameters

* <span></span>**26. PBR Metallic:** Shades the geometry with the Standard Metallic lighting model (PBR)

* <span></span>**27. PBR Specular:** Shades the geometry with the Standard Specular lighting model (PBR)

* <span></span>**28. PBR Specular Emission:** Shades the geometry with the Standard Specular lighting model (PBR) and makes the geometry to glow in the areas not filtered in the specular map (non-black areas)

* <span></span>**29. PBR Specular Reversed Map:** Shades the geometry with the Standard Specular lighting model (PBR) but considering the specular map reversed in comparison with 27 (black areas are shinny and white/gray areas are mostly dull)

* <span></span>**30. Lighting Simple Lambert:** Shades the geometry with a basic form of a custom Lambert lightinng

* <span></span>**31. Lighting Simple Blinn-Phong:** Shades the geometry with a basic form of a custom Blinn Phong lighting

* <span></span>**32. Lighting Toon:** Shades the geometry based on a main texture as well as a toon shading effect driven by the provided ramp map

* <span></span>**33. Lighting Toon Albedo:** Shades the geometry based on a color as well as a toon shading effect driven by the provided ramp map. The toon effect is applied based on both the view and the lights direction (as if two toon effects where applied accumulatively)

* <span></span>**34. Lighting Toon Specular:** Shades the geometry by applying a ramp map to the surface albedo based on the normal and viewDir to determine the uvs. It uses a BlinnPhong shading to support specular highlights

* <span></span>**35. Lighting Simple Blinn-Phong Anim:** Shades the geometry with a basic form of a custom Blinn Phong lighting including a simple Sin-based color change over time

* <span></span>**36. Simple Alpha:** Shades the geometry using the alpha channel of the main texture to drive the transparency

* <span></span>**37. Hard Rim Hologram:** Creates a Rim effect highlighting just the borders of the geometry with the given color and intensity parameters, considering also a threshold used to control the start of the Rim area. The shading is also done so that the geometry gets more transparent at the center and less transparent at the edges achieving a kind of a Hologram effect

* <span></span>**38. Hard Rim Hologram Anim:** Creates a Rim effect highlighting just the borders of the geometry with the given color and intensity parameters, considering also a threshold used to control the start of the Rim area. The shading is also done so that the geometry gets more transparent at the center and less transparent at the edges achieving a kind of a Hologram effect. The hologram effect fades in and out with time

* <span></span>**39. Simple Blend:** Shades the geometry using a few different blend approaches

* <span></span>**40. Decal:** Shades the geometry using a decal texture. All pixels will be we visible except for black ones

* <span></span>**41. Billboard:** Shades the geometry with transparency considering it will be used as part of a billboard so it is drawn from both sides (front-face and back-face, no back-face culling)

* <span></span>**42. Decal Over Tex:** Shades the geometry with a given base texture plus a decal texture drawn right onto the base one

* <span></span>**43.1. X-Ray Scanner:** Writes the geometry to the stencil buffer without considering writing depth and frames buffer This could be used as a see through hole when combine with the proper shader on another object

* <span></span>**43.2. X-Ray Scanner Frame:** Makes the geometry visible and applies a rim effect only on those areas which are not written on the stencil buffer Combined with the 43.1. shader (put into another object) it allows to make a frame for the scanner

* <span></span>**43.3. X-Ray Passtrough:** Makes the geometry visible only on those areas which are not written on the stencil buffer. Combined with the 43.1. shader (put into another object) it allows to simulate that the geometry has a see through hole

* <span></span>**44.1. Windowed World Viewer:**  Writes the geometry to the stencil buffer given the Ref number, the Comp function to use and the Operation to apply on the buffer. These parameters are passed as an input to the shader so they can be set per-material (they should be set with the values added as a comment in the Stencil section). Note that the shader does not write to the Frame Buffer (ColorMarsk 0), it does only fills the stencil

* <span></span>**44.2. WindowedWorldObject:** Writes the geometry considering ony what is into the corresponding stencil buffer (given by Ref). The Comp function and the Operation to apply on the buffer are passed as an input to the shader so they can be set per-material (they should be set with the values added as a comment in the Stencil section). Note that the shader does write to the Frame Buffer (no ColorMarsk parameter)

* <span></span>**45. Simple VF:** A simple vertex shader that colors the geometry per-pixel based on pixel's X position. The interesting thing to note here is that the color assigned corresponds to the vertex screen coords on the frag

* <span></span>**46. Simple VF UV Displacement:** A simple vertex shader that colors the geometry based on a texture which is offseted using the Sin function

* <span></span>**47. Simple VF UV Colouring:** A simple vertex shader that colors the geometry based either on a texture or the UV values of the mesh

* <span></span>**48. Screen Grab VF:** Grabs the rendered scene and applies it as a texture to the geometry

* <span></span>**49. Diffuse VF:** Shades the geometry using a simple diffuse Lambert lighting model

* <span></span>**50. Diffuse VF Shadow Casting:** Shades the geometry using a simple diffuse Lambert lighting model including casting shadows to other objects

* <span></span>**51. Diffuse VF Shadow Receiving:** Shades the geometry using a simple diffuse Lambert lighting model including casting shadows to other objects and receiving shadows from othe objects. It also provides the option to alter the color of the received shadows

* <span></span>**52. Normal Extrusion:** Extrudes the vertices based on the extrude amount parameter

* <span></span>**53. Simple Outline:** Shades the geometry with an outline of the specified color and width. Take into account that this solution, although simple, requires the shader to be set on the Transparency render queue, which might not be desirable

* <span></span>**54. Advanced Outline:** Shades the geometry with an outline of the specified color and width. In contrast to the previous outline solution it is not required to set it in the Transparent queue so it's more flexible and natural. It also outlines parts of the geometry not outlined by the previous shader

* <span></span>**55. Glass Effect:** Shades the geometry with a glass effect that makes all what's behind it a little blured and distorted

* <span></span>**56. Waves:** Alters the geometry so to make it wobble given the oscilation frequency, amplitude and speed. It does wobble the geometry in X and Z directions following sin and cos functions respectively

* <span></span>**57. ScrollingWaves:** Alters the geometry so to make it wobble given the oscilation frequency, amplitude and speed. It does wobble the geometry in X and Z directions following sin and cos functions respectively. It also scrolls the texture applied over the surface based on some scroll input parameters, and includes an additional texture (for example, to represent foam over the water) which also scrolls at a different pace

* <span></span>**58. Plasma:** Shades the geometry with RGB coloured psychodelic circular patterns (akin a plasma effect)

* <span></span>**59. Plasma VF:** Shades the geometry with RGB coloured psychodelic circular patterns (akin a plasma effect) using a VF shader 
