
.thumb

.global DecompressImg_ShopGoldBox_Hook
.type DecompressImg_ShopGoldBox_Hook, %function 
DecompressImg_ShopGoldBox_Hook: 
push  {r14}
bl DecompressImg_ShopGoldBox
pop {r3} 
ldr r3, =0x80B4E31 
bx r3 
.ltorg 

.global Decompress_Img_PrepItemUseScreen_Hook
.type Decompress_Img_PrepItemUseScreen_Hook, %function 
Decompress_Img_PrepItemUseScreen_Hook: 
push  {r14}
bl Decompress_Img_PrepItemUseScreen
pop {r3} 
ldr r3, =0x809C661 
bx r3 
.ltorg 




