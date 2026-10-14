import unreal

PATH='/Game/Core/Widgets/MainMenu/UI/WBP_MainMenu'
b=unreal.load_asset(PATH)
t=unreal.find_object(b,'WidgetTree')
def w(n): return unreal.find_object(t,n)
def c(r,g,b,a=1): return unreal.LinearColor(r,g,b,a)
def slate(col): return unreal.SlateColor(specified_color=col)
navy=c(.008,.014,.025)
panel=c(.018,.03,.048)
raised=c(.035,.055,.08)
cyan=c(.02,.72,.87)
white=c(.86,.93,1)
muted=c(.37,.49,.61)
def brush(col):
    result=unreal.SlateBrush(tint_color=slate(col),draw_as=unreal.SlateBrushDrawType.ROUNDED_BOX)
    outline=result.outline_settings; outline.rounding_type=unreal.SlateBrushRoundingType.FIXED_RADIUS; outline.corner_radii=unreal.Vector4(8,8,8,8); result.outline_settings=outline
    return result
def text(n,s,size=18,col=white):
    x=w(n); x.set_text(s); f=x.font; f.size=size; x.set_font(f); x.set_color_and_opacity(slate(col))
def pos(n,x,y,sx,sy):
    sl=w(n).slot; sl.set_anchors(unreal.Anchors(unreal.Vector2D(.5,.5),unreal.Vector2D(.5,.5))); sl.set_alignment(unreal.Vector2D(0,0)); sl.set_position(unreal.Vector2D(x,y)); sl.set_size(unreal.Vector2D(sx,sy))
def button(n,primary=False):
    x=w(n); style=x.widget_style
    style.normal=brush(cyan if primary else raised)
    style.hovered=brush(c(.04,.85,.98) if primary else c(.065,.11,.16))
    style.pressed=brush(c(.01,.45,.6))
    style.disabled=brush(panel)
    x.set_style(style); x.set_background_color(c(1,1,1)); x.set_color_and_opacity(c(1,1,1))
for n in ['Image_2']:
    w(n).set_brush(unreal.SlateBrush(tint_color=slate(navy),draw_as=unreal.SlateBrushDrawType.IMAGE)); w(n).set_color_and_opacity(c(1,1,1))
for n in ['Image_0','Image','Image_1','Image_4']:
    w(n).set_brush(brush(panel)); w(n).set_color_and_opacity(c(1,1,1))
pos('TextBlock_3',-576,-306,280,54); text('TextBlock_3','SETTINGS',32)
w('TextBlock_3').set_visibility(unreal.SlateVisibility.VISIBLE)
pos('TextBlock_27',-576,-260,220,28); text('TextBlock_27','MAKE IT YOUR GAME',11,cyan)
pos('EditableText_0',260,-294,316,40)
pos('VerticalBox_1',-576,-184,212,264)
pos('WidgetSwitcher_1',-334,-222,910,468)
for n,s in [('TextBlock_4','01   GAMEPLAY'),('TextBlock_5','02   AUDIO'),('TextBlock_6','03   VIDEO'),('TextBlock_28','04   APPEARANCE')]: text(n,s,15)
for n in ['Button_0','Button_1','Button_2','Costume','Btn_SettingsBack']: button(n)
button('Btn_ApplySettings',True)
text('Txt_ApplySettingsLabel','APPLY CHANGES',15,navy)
text('Txt_SettingsBackLabel','DISCARD & BACK',14)
pos('Btn_SettingsBack',-576,276,212,48); pos('Btn_ApplySettings',364,276,212,48)
for n,s in [('TextBlock_8','CONTROL & CAMERA'),('TextBlock_9','SOUND & MIX'),('TextBlock_12','GRAPHICS & DISPLAY'),('TextBlock_29','CHARACTER STYLE')]:text(n,s,20)
for n in ['TextBlock_108','TextBlock_10','TextBlock_11']+[f'TextBlock_{i}' for i in range(13,19)]+[f'TextBlock_{i}' for i in range(30,35)]:
    x=w(n); f=x.font; f.size=17; x.set_font(f); x.set_color_and_opacity(slate(white))
for n in ['HorizontalBox_101','HorizontalBox','HorizontalBox_1']+[f'HorizontalBox_{i}' for i in range(2,8)]+[f'HorizontalBox_{i}' for i in range(11,16)]:
    w(n).slot.set_padding(unreal.Margin(8,2,8,2))
for n in [f'TextBlock_{i}' for i in range(13,19)]+[f'TextBlock_{i}' for i in range(30,35)]:
    w(n).slot.set_padding(unreal.Margin(12,2,12,2))
for n in ['Option_OverallGraphics','Option_TextureQuality','Option_ShadowQuality','Option_ViewDistance','Option_AntiAliasing','Option_VSync','Characters_Option','Hair_Option','Top_Option','Leg_WearOption','Shoe_Option']:
    w(n).slot.set_padding(unreal.Margin(12,1,12,1))
for n in ['SLIDER_CameraSensitivity','SLIDER_MusicVolume','SLIDER_SFXVolume']:
    x=w(n); st=x.widget_style
    st.normal_bar_image=brush(raised); st.hovered_bar_image=brush(muted); st.disabled_bar_image=brush(panel)
    thumb=st.normal_thumb_image; thumb.tint_color=slate(cyan); thumb.draw_as=unreal.SlateBrushDrawType.ROUNDED_BOX
    st.normal_thumb_image=thumb; st.hovered_thumb_image=thumb; st.disabled_thumb_image=brush(muted); st.bar_thickness=5
    x.set_editor_property('widget_style',st); x.set_slider_bar_color(c(1,1,1)); x.set_slider_handle_color(c(1,1,1))
    x.slot.set_vertical_alignment(unreal.VerticalAlignment.V_ALIGN_CENTER)
    x.slot.set_padding(unreal.Margin(24,12,12,12))
canvas=w('SettingsCanvasPanel')
def new_text(n,s,x,y,sx,sy,size=14,col=muted):
    obj=w(n)
    if not obj:
        obj=unreal.new_object(unreal.TextBlock,outer=t,name=n); canvas.add_child_to_canvas(obj)
    pos(n,x,y,sx,sy);text(n,s,size,col)
new_text('Codex_ProfileLabel','PLAYER PROFILE',260,-321,316,24,10,cyan)
new_text('Codex_SettingsHint','Changes are saved when you apply.',-334,282,420,32,13,muted)
new_text('Codex_LeftHint','PERSONALIZE YOUR PLAY\n\nFine-tune your controls, sound\nand visual quality.',-576,134,210,104,12,muted)
new_text('Codex_HeaderHint','PREFERENCES  /  PROP HUNT',-334,-270,560,24,11,muted)
unreal.EditorAssetLibrary.save_loaded_asset(b)
print('Settings visual pass saved')

# Keep the Debug overlay in the same visual language.
PATH='/Game/Core/Widgets/WBP_DeveloperDebugPanel'
b=unreal.load_asset(PATH);t=unreal.find_object(b,'WidgetTree')
for n in ['DebugCardBorder','Border_HostTools']:
    w(n).set_brush(brush(navy if n=='DebugCardBorder' else panel));w(n).set_brush_color(c(1,1,1))
for n in ['Btn_CloseDebug','Btn_RefreshDebug','Btn_CommitHunterCount','Btn_ServerPropAction','Btn_ServerHunterAction']:button(n)
for n in ['Txt_DebugHeading','Txt_CloseLabel','Txt_RefreshLabel','Txt_CommitHunterLabel','Txt_ServerPropLabel','Txt_ServerHunterLabel','Txt_HostToolsHeader','Txt_HostToolsNotice','Txt_HunterCountLabel','Txt_HostToolsStatus','Txt_FPS','Txt_MapNet','Txt_RolePing','Txt_PlayerCount','Txt_BuildStatus']:
    obj=w(n); f=obj.font;f.size=12 if n=='Txt_HostToolsNotice' else 15;obj.set_font(f);obj.set_color_and_opacity(slate(muted if n in ['Txt_HostToolsNotice','Txt_HostToolsStatus'] else white))
text('Txt_DebugHeading','DEVELOPER CONSOLE',22)
text('Txt_CloseLabel','CLOSE  /  `',12)
text('Txt_HostToolsHeader','HOST CONTROLS',13,cyan)
text('Txt_HostToolsNotice','Development only. Host actions change match roles and rules.',12,muted)
text('Txt_RefreshLabel','REFRESH DIAGNOSTICS',12)
unreal.EditorAssetLibrary.save_loaded_asset(b)
print('Debug visual pass saved')
