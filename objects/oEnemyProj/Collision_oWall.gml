audio_play_sound(snd_Die,5,false);
ScreenShake(4,20);
for(var i = 0; i < 20; i++)
{
	instance_create_layer(other.x,other.y,"VFX",oParticleExplode);
}
instance_create_layer(x,y,"VFX",oDeathVFX);

event_inherited();