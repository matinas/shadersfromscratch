# shadersfromscratch
Experimenting with Surface Shaders (mainly) as part of a couple of tutorials and courses. List of all the generated shaders you can find in Assets/Shaders folder, each one including an image/video demoing the effect.

* <span></span>**1. Emission Albedo:** Very simple shader that shades the geometry based on the albedo and emission colors given as parameter

   <img src="https://user-images.githubusercontent.com/5633645/39080208-817b7c34-4500-11e8-8ec5-a52781e1629c.png" alt="1. Emission Albedo" style="max-width:100%" width="512" heigth="512">
   
* <span></span>**2. Emission Albedo Normal** Very simple shader that shades the geometry based on the albedo and emission colors passed as parameter. It also sets the geometry normals based on an additional color parameter

   <img src="https://user-images.githubusercontent.com/5633645/39080209-81af5108-4500-11e8-9c7a-8fd69307f7d7.png" alt="1. Emission Albedo Normal" style="max-width:100%" width="512" heigth="512">

* <span></span>**3. Skybox Reflection:** Shades the object with a given diffuse texture plus a given cube map to set the emission based on the reflection vector for each pixel, generating a reflection effect. If the geometry is flat shaded it should behave as a perfect mirror (no interpolation of the reflection vector before sampling the cube map)

   <img src="https://user-images.githubusercontent.com/5633645/39080210-81cf413e-4500-11e8-936a-fd7ea015627b.png" alt="3. Skybox Reflection" style="max-width:100%" width="512" heigth="512">

* <span></span>**4. Skybox Reflection Albedo:** Shades the object with a given diffuse texture plus a given cube map to set the emission based on the reflection vector for each pixel, generating a reflection effect. If the geometry is flat shaded it should behave as a perfect mirror (no interpolation of the reflection vector before sampling the cube map). In contrast with previous shader it also accepts a color to compose with the reflective one.

   <img src="https://user-images.githubusercontent.com/5633645/39080454-4ec1a8ea-4505-11e8-8dde-41e7f737a136.gif" alt="4. Skybox Reflection Albedo" style="max-width:100%" width="512" heigth="512">
   
   <img src="https://user-images.githubusercontent.com/5633645/39080482-dcca4b56-4505-11e8-9ab5-81f847a054a3.gif" alt="4. Skybox Reflection Albedo (flat)" style="max-width:100%" width="512" heigth="512">

* <span></span>**5. Full Green:** Takes a texture to use as the albedo colour and just turns up the green channel to full

   <img src="https://user-images.githubusercontent.com/5633645/39080211-81f2393c-4500-11e8-84c1-a497c784b39b.png" alt="5. Full Green" style="max-width:100%" width="512" heigth="512">

* <span></span>**6. Green Texture:** Quite similar to the previous shader but composes the given texture with a gree color

   <img src="https://user-images.githubusercontent.com/5633645/39080208-817b7c34-4500-11e8-8ec5-a52781e1629c.png" alt="1. Emission Albedo" style="max-width:100%" width="512" heigth="512">

* <span></span>**7. Emission Albedo Texture:** Shades the geometry with a given albedo texture as well as an emmision texture

   <img src="https://user-images.githubusercontent.com/5633645/39080212-821279fe-4500-11e8-8de3-68ba3ba71fea.png" alt="7. Emission Albedo Texture" style="max-width:100%" width="512" heigth="512">

* <span></span>**8. Diffuse Normal:** Shades the geometry with a given albedo texture and a normal map, which bumpinness is driven by another parameter

   <img src="https://user-images.githubusercontent.com/5633645/39080213-82337834-4500-11e8-88a3-3e21be1d2538.png" alt="8. Diffuse Normal" style="max-width:100%" width="512" heigth="512">

* <span></span>**9. Diffuse Normal Intensity:** Shades the geometry with a given albedo texture and a normal map, which bumpinness is driven by another parameter. It also includes an additional parameter to turn the brightness over the geometry up and down

   <img src="https://user-images.githubusercontent.com/5633645/39080215-825458e2-4500-11e8-9d4f-c154092260bc.png" alt="9. Diffuse Normal Intensity" style="max-width:100%" width="512" heigth="512">

* <span></span>**11. Snow:** Shades the geometry with a given texture and color adding an effect so part of the geometry gets whitened as it was snow. The direction, color and amount of snow is configurable through a couple of input parameters

   <img src="https://user-images.githubusercontent.com/5633645/39080216-8275e49e-4500-11e8-8e0d-d14c0c54b4c3.png" alt="11. Snow" style="max-width:100%" width="512" heigth="512">

* <span></span>**14. Normal Scaler:** Shades the geometry with white color but sets the normal with the given parameters so to affect the way the light is calculated

   <img src="https://user-images.githubusercontent.com/5633645/39080218-82998d9a-4500-11e8-9f7a-f7c01611d81e.png" alt="14. Normal Scaler" style="max-width:100%" width="512" heigth="512">

* <span></span>**15. Normal Visualizer:** Shades the geometry with the normal vector used as a color, modified to control the amount of bump (X and Y coords) and the intensity/length (Z coord)

   <img src="https://user-images.githubusercontent.com/5633645/39080219-82bb6294-4500-11e8-8d5c-5cb87cd492b5.png" alt="15. Normal Visualizer" style="max-width:100%" width="512" heigth="512">

* <span></span>**16. Skybox Reflection Bump:** This shader is a combination of 4 and 9, so it includes reflection based on a cubemap as well as bump mapping based on a given normal map and a few parameters settings (intensity of bump, bump amount, etc)

   <img src="https://user-images.githubusercontent.com/5633645/39080483-e79e9f5a-4505-11e8-8ff5-dcdea640bfdc.gif" alt="16. Skybox Reflection Bump" style="max-width:100%" width="512" heigth="512">

* <span></span>**17. Metallic Reflective Bump:** Shades the geometry with a metallic reflective bump mapped material. Takes a normal map and a cube map. The normal map is unwrapped onto the surface normals and multiplied by a fixed factor. The cube map is used to set the Albedo.

   <img src="https://user-images.githubusercontent.com/5633645/39080220-82dbaf54-4500-11e8-92f2-841911d0aba6.png" alt="17. Metallic Reflective Bump" style="max-width:100%" width="512" heigth="512">

* <span></span>**18. Dot Product Albedo:** Shades the geometry based on the angle between the normals and the view direction (used to set the color's red channel). It uses a color displacement parameter to allowing to invert the shading

   <img src="https://user-images.githubusercontent.com/5633645/39080221-82fc3850-4500-11e8-8f73-3e751c6e7078.png" alt="18. Dot Product Albedo" style="max-width:100%" width="512" heigth="512">

* <span></span>**19. Rim:** Creates a Rim effect highlighting just the borders of the geomtry with the given color and intensity parameters

   <img src="https://user-images.githubusercontent.com/5633645/39080222-831c59a0-4500-11e8-9346-68f0aa17d44d.png" alt="19. Rim" style="max-width:100%" width="512" heigth="512">

* <span></span>**20. Hard Rim:** Creates a Rim effect highlighting just the borders of the geometry with the given color and intensity parameters, considering also a threshold used to control the start of the Rim area

   <img src="https://user-images.githubusercontent.com/5633645/39080416-7778dca0-4504-11e8-945a-c3b28fed17e8.gif" alt="20. Hard Rim" style="max-width:100%" width="512" heigth="512">

* <span></span>**21. Rim Bands:** Creates a Rim effect highlighting just the borders of the geomtry with the given colors and intensity parameters. The color thresholds allow to configure the size of the color bands

   <img src="https://user-images.githubusercontent.com/5633645/39080223-833cefd0-4500-11e8-8efe-ef562bc7ce02.png" alt="21. Rim Bands" style="max-width:100%" width="512" heigth="512">

* <span></span>**22. Stripes:** Shades the geometry by interchanging two colors depending on the world position, giving a multicolor horizontal band effect as a result

   <img src="https://user-images.githubusercontent.com/5633645/39080224-8360cbee-4500-11e8-96ac-1529cf8d132e.png" alt="22. Stripes" style="max-width:100%" width="512" heigth="512">

* <span></span>**23. Striped Rim:** Shades the geometry by interchanging two colors depending on the world position, giving a multicolor horizontal band effect as a result. The band is rimmed to the edges depending on the given threshold parameter.

   <img src="https://user-images.githubusercontent.com/5633645/39080225-83994500-4500-11e8-83f6-b9cabf925383.png" alt="23. Striped Rim" style="max-width:100%" width="512" heigth="512">

* <span></span>**24. Textured Striped Rim:** Shades the geometry with a base texture in addition to interchanging two colors depending on the world position, giving a multicolor horizontal band effect as a result. The band is rimmed to the edges depending on the given threshold parameter, and the size of each band is also configurable

   <img src="https://user-images.githubusercontent.com/5633645/39080226-83bdc07e-4500-11e8-8520-8a8e097501fa.png" alt="24. Textured Striped Rim" style="max-width:100%" width="512" heigth="512">

* <span></span>**25. Basic Blinn Phong:** Shades the geometry with speculear Blinn Phong lighting based on the input parameters

   <img src="https://user-images.githubusercontent.com/5633645/39080227-83f061d2-4500-11e8-8dda-5495bdd41cf0.png" alt="25. Basic Blinn Phong" style="max-width:100%" width="512" heigth="512">

* <span></span>**26. PBR Metallic:** Shades the geometry with the Standard Metallic lighting model (PBR)

   <img src="https://user-images.githubusercontent.com/5633645/39080228-842dcfa4-4500-11e8-9e3b-c689d4e9f840.png" alt="26. PBR Metallic" style="max-width:100%" width="512" heigth="512">

* <span></span>**27. PBR Specular:** Shades the geometry with the Standard Specular lighting model (PBR)

   <img src="https://user-images.githubusercontent.com/5633645/39080229-844ea17a-4500-11e8-8c6f-923bfb1cc7e7.png" alt="27. PBR Specular" style="max-width:100%" width="512" heigth="512">

* <span></span>**28. PBR Specular Emission:** Shades the geometry with the Standard Specular lighting model (PBR) and makes the geometry to glow in the areas not filtered in the specular map (non-black areas)

   <img src="https://user-images.githubusercontent.com/5633645/39080230-846ef826-4500-11e8-8dac-83184b85489a.png" alt="28. PBR Specular Emission" style="max-width:100%" width="512" heigth="512">

* <span></span>**29. PBR Specular Reversed Map:** Shades the geometry with the Standard Specular lighting model (PBR) but considering the specular map reversed in comparison with 27 (black areas are shinny and white/gray areas are mostly dull)

   <img src="https://user-images.githubusercontent.com/5633645/39080231-848fff26-4500-11e8-9468-704a55a8391c.png" alt="29. PBR Specular Reversed Map" style="max-width:100%" width="512" heigth="512">

* <span></span>**30. Lighting Simple Lambert:** Shades the geometry with a basic form of a custom Lambert lightinng

   <img src="https://user-images.githubusercontent.com/5633645/39080232-84b0cd32-4500-11e8-9e79-78744d8c8864.png" alt="30. Lighting Simple Lambert" style="max-width:100%" width="512" heigth="512">

* <span></span>**31. Lighting Simple Blinn-Phong:** Shades the geometry with a basic form of a custom Blinn Phong lighting

   <img src="https://user-images.githubusercontent.com/5633645/39080208-817b7c34-4500-11e8-8ec5-a52781e1629c.png" alt="1. Emission Albedo" style="max-width:100%" width="256" heigth="256">

* <span></span>**32. Lighting Toon:** Shades the geometry based on a main texture as well as a toon shading effect driven by the provided ramp map

   <img src="https://user-images.githubusercontent.com/5633645/39080208-817b7c34-4500-11e8-8ec5-a52781e1629c.png" alt="1. Emission Albedo" style="max-width:100%" width="256" heigth="256">

* <span></span>**33. Lighting Toon Albedo:** Shades the geometry based on a color as well as a toon shading effect driven by the provided ramp map. The toon effect is applied based on both the view and the lights direction (as if two toon effects where applied accumulatively)

   <img src="https://user-images.githubusercontent.com/5633645/39080208-817b7c34-4500-11e8-8ec5-a52781e1629c.png" alt="1. Emission Albedo" style="max-width:100%" width="256" heigth="256">

* <span></span>**34. Lighting Toon Specular:** Shades the geometry by applying a ramp map to the surface albedo based on the normal and viewDir to determine the uvs. It uses a BlinnPhong shading to support specular highlights

   <img src="https://user-images.githubusercontent.com/5633645/39080208-817b7c34-4500-11e8-8ec5-a52781e1629c.png" alt="1. Emission Albedo" style="max-width:100%" width="256" heigth="256">

* <span></span>**35. Lighting Simple Blinn-Phong Anim:** Shades the geometry with a basic form of a custom Blinn Phong lighting including a simple Sin-based color change over time

   <img src="https://user-images.githubusercontent.com/5633645/39080208-817b7c34-4500-11e8-8ec5-a52781e1629c.png" alt="1. Emission Albedo" style="max-width:100%" width="256" heigth="256">

* <span></span>**36. Simple Alpha:** Shades the geometry using the alpha channel of the main texture to drive the transparency

   <img src="https://user-images.githubusercontent.com/5633645/39080208-817b7c34-4500-11e8-8ec5-a52781e1629c.png" alt="1. Emission Albedo" style="max-width:100%" width="256" heigth="256">

* <span></span>**37. Hard Rim Hologram:** Creates a Rim effect highlighting just the borders of the geometry with the given color and intensity parameters, considering also a threshold used to control the start of the Rim area. The shading is also done so that the geometry gets more transparent at the center and less transparent at the edges achieving a kind of a Hologram effect

   <img src="https://user-images.githubusercontent.com/5633645/39080208-817b7c34-4500-11e8-8ec5-a52781e1629c.png" alt="1. Emission Albedo" style="max-width:100%" width="256" heigth="256">

* <span></span>**38. Hard Rim Hologram Anim:** Creates a Rim effect highlighting just the borders of the geometry with the given color and intensity parameters, considering also a threshold used to control the start of the Rim area. The shading is also done so that the geometry gets more transparent at the center and less transparent at the edges achieving a kind of a Hologram effect. The hologram effect fades in and out with time

   <img src="https://user-images.githubusercontent.com/5633645/39080208-817b7c34-4500-11e8-8ec5-a52781e1629c.png" alt="1. Emission Albedo" style="max-width:100%" width="256" heigth="256">

* <span></span>**39. Simple Blend:** Shades the geometry using a few different blend approaches

   <img src="https://user-images.githubusercontent.com/5633645/39080208-817b7c34-4500-11e8-8ec5-a52781e1629c.png" alt="1. Emission Albedo" style="max-width:100%" width="256" heigth="256">

* <span></span>**40. Decal:** Shades the geometry using a decal texture. All pixels will be we visible except for black ones

   <img src="https://user-images.githubusercontent.com/5633645/39080208-817b7c34-4500-11e8-8ec5-a52781e1629c.png" alt="1. Emission Albedo" style="max-width:100%" width="256" heigth="256">

* <span></span>**41. Billboard:** Shades the geometry with transparency considering it will be used as part of a billboard so it is drawn from both sides (front-face and back-face, no back-face culling)

   <img src="https://user-images.githubusercontent.com/5633645/39080208-817b7c34-4500-11e8-8ec5-a52781e1629c.png" alt="1. Emission Albedo" style="max-width:100%" width="256" heigth="256">

* <span></span>**42. Decal Over Tex:** Shades the geometry with a given base texture plus a decal texture drawn right onto the base one

   <img src="https://user-images.githubusercontent.com/5633645/39080208-817b7c34-4500-11e8-8ec5-a52781e1629c.png" alt="1. Emission Albedo" style="max-width:100%" width="256" heigth="256">

* <span></span>**43.1. X-Ray Scanner:** Writes the geometry to the stencil buffer without considering writing depth and frames buffer This could be used as a see through hole when combine with the proper shader on another object

   <img src="https://user-images.githubusercontent.com/5633645/39080208-817b7c34-4500-11e8-8ec5-a52781e1629c.png" alt="1. Emission Albedo" style="max-width:100%" width="256" heigth="256">

* <span></span>**43.2. X-Ray Scanner Frame:** Makes the geometry visible and applies a rim effect only on those areas which are not written on the stencil buffer Combined with the 43.1. shader (put into another object) it allows to make a frame for the scanner

   <img src="https://user-images.githubusercontent.com/5633645/39080208-817b7c34-4500-11e8-8ec5-a52781e1629c.png" alt="1. Emission Albedo" style="max-width:100%" width="256" heigth="256">

* <span></span>**43.3. X-Ray Passtrough:** Makes the geometry visible only on those areas which are not written on the stencil buffer. Combined with the 43.1. shader (put into another object) it allows to simulate that the geometry has a see through hole

   <img src="https://user-images.githubusercontent.com/5633645/39080208-817b7c34-4500-11e8-8ec5-a52781e1629c.png" alt="1. Emission Albedo" style="max-width:100%" width="256" heigth="256">

* <span></span>**44.1. Windowed World Viewer:**  Writes the geometry to the stencil buffer given the Ref number, the Comp function to use and the Operation to apply on the buffer. These parameters are passed as an input to the shader so they can be set per-material (they should be set with the values added as a comment in the Stencil section). Note that the shader does not write to the Frame Buffer (ColorMarsk 0), it does only fills the stencil

   <img src="https://user-images.githubusercontent.com/5633645/39080208-817b7c34-4500-11e8-8ec5-a52781e1629c.png" alt="1. Emission Albedo" style="max-width:100%" width="256" heigth="256">

* <span></span>**44.2. WindowedWorldObject:** Writes the geometry considering ony what is into the corresponding stencil buffer (given by Ref). The Comp function and the Operation to apply on the buffer are passed as an input to the shader so they can be set per-material (they should be set with the values added as a comment in the Stencil section). Note that the shader does write to the Frame Buffer (no ColorMarsk parameter)

   <img src="https://user-images.githubusercontent.com/5633645/39080208-817b7c34-4500-11e8-8ec5-a52781e1629c.png" alt="1. Emission Albedo" style="max-width:100%" width="256" heigth="256">

* <span></span>**45. Simple VF:** A simple vertex shader that colors the geometry per-pixel based on pixel's X position. The interesting thing to note here is that the color assigned corresponds to the vertex screen coords on the frag

   <img src="https://user-images.githubusercontent.com/5633645/39080208-817b7c34-4500-11e8-8ec5-a52781e1629c.png" alt="1. Emission Albedo" style="max-width:100%" width="256" heigth="256">

* <span></span>**46. Simple VF UV Displacement:** A simple vertex shader that colors the geometry based on a texture which is offseted using the Sin function

   <img src="https://user-images.githubusercontent.com/5633645/39080208-817b7c34-4500-11e8-8ec5-a52781e1629c.png" alt="1. Emission Albedo" style="max-width:100%" width="256" heigth="256">

* <span></span>**47. Simple VF UV Colouring:** A simple vertex shader that colors the geometry based either on a texture or the UV values of the mesh

   <img src="https://user-images.githubusercontent.com/5633645/39080208-817b7c34-4500-11e8-8ec5-a52781e1629c.png" alt="1. Emission Albedo" style="max-width:100%" width="256" heigth="256">

* <span></span>**48. Screen Grab VF:** Grabs the rendered scene and applies it as a texture to the geometry

   <img src="https://user-images.githubusercontent.com/5633645/39080208-817b7c34-4500-11e8-8ec5-a52781e1629c.png" alt="1. Emission Albedo" style="max-width:100%" width="256" heigth="256">

* <span></span>**49. Diffuse VF:** Shades the geometry using a simple diffuse Lambert lighting model

<img src="https://user-images.githubusercontent.com/5633645/39080208-817b7c34-4500-11e8-8ec5-a52781e1629c.png" alt="1. Emission Albedo" style="max-width:100%" width="256" heigth="256">

* <span></span>**50. Diffuse VF Shadow Casting:** Shades the geometry using a simple diffuse Lambert lighting model including casting shadows to other objects

   <img src="https://user-images.githubusercontent.com/5633645/39080208-817b7c34-4500-11e8-8ec5-a52781e1629c.png" alt="1. Emission Albedo" style="max-width:100%" width="256" heigth="256">

* <span></span>**51. Diffuse VF Shadow Receiving:** Shades the geometry using a simple diffuse Lambert lighting model including casting shadows to other objects and receiving shadows from othe objects. It also provides the option to alter the color of the received shadows

   <img src="https://user-images.githubusercontent.com/5633645/39080208-817b7c34-4500-11e8-8ec5-a52781e1629c.png" alt="1. Emission Albedo" style="max-width:100%" width="256" heigth="256">

* <span></span>**52. Normal Extrusion:** Extrudes the vertices based on the extrude amount parameter

   <img src="https://user-images.githubusercontent.com/5633645/39080208-817b7c34-4500-11e8-8ec5-a52781e1629c.png" alt="1. Emission Albedo" style="max-width:100%" width="256" heigth="256">

* <span></span>**53. Simple Outline:** Shades the geometry with an outline of the specified color and width. Take into account that this solution, although simple, requires the shader to be set on the Transparency render queue, which might not be desirable

   <img src="https://user-images.githubusercontent.com/5633645/39080208-817b7c34-4500-11e8-8ec5-a52781e1629c.png" alt="1. Emission Albedo" style="max-width:100%" width="256" heigth="256">

* <span></span>**54. Advanced Outline:** Shades the geometry with an outline of the specified color and width. In contrast to the previous outline solution it is not required to set it in the Transparent queue so it's more flexible and natural. It also outlines parts of the geometry not outlined by the previous shader

   <img src="https://user-images.githubusercontent.com/5633645/39080208-817b7c34-4500-11e8-8ec5-a52781e1629c.png" alt="1. Emission Albedo" style="max-width:100%" width="256" heigth="256">

* <span></span>**55. Glass Effect:** Shades the geometry with a glass effect that makes all what's behind it a little blured and distorted

   <img src="https://user-images.githubusercontent.com/5633645/39080208-817b7c34-4500-11e8-8ec5-a52781e1629c.png" alt="1. Emission Albedo" style="max-width:100%" width="256" heigth="256">

* <span></span>**56. Waves:** Alters the geometry so to make it wobble given the oscilation frequency, amplitude and speed. It does wobble the geometry in X and Z directions following sin and cos functions respectively

   <img src="https://user-images.githubusercontent.com/5633645/39080208-817b7c34-4500-11e8-8ec5-a52781e1629c.png" alt="1. Emission Albedo" style="max-width:100%" width="256" heigth="256">

* <span></span>**57. ScrollingWaves:** Alters the geometry so to make it wobble given the oscilation frequency, amplitude and speed. It does wobble the geometry in X and Z directions following sin and cos functions respectively. It also scrolls the texture applied over the surface based on some scroll input parameters, and includes an additional texture (for example, to represent foam over the water) which also scrolls at a different pace

   <img src="https://user-images.githubusercontent.com/5633645/39080208-817b7c34-4500-11e8-8ec5-a52781e1629c.png" alt="1. Emission Albedo" style="max-width:100%" width="256" heigth="256">

* <span></span>**58. Plasma:** Shades the geometry with RGB coloured psychodelic circular patterns (akin a plasma effect)

   <img src="https://user-images.githubusercontent.com/5633645/39080208-817b7c34-4500-11e8-8ec5-a52781e1629c.png" alt="1. Emission Albedo" style="max-width:100%" width="256" heigth="256">

* <span></span>**59. Plasma VF:** Shades the geometry with RGB coloured psychodelic circular patterns (akin a plasma effect) using a VF shader 

   <img src="https://user-images.githubusercontent.com/5633645/39080208-817b7c34-4500-11e8-8ec5-a52781e1629c.png" alt="1. Emission Albedo" style="max-width:100%" width="256" heigth="256">
