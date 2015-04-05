package com.ukuleledog.games.evapixel.elements;

import com.ukuleledog.games.core.AnimatedObject;
import openfl.Assets;

/**
 * ...
 * @author matt
 */
class Misato extends AnimatedObject
{

	public function new() 
	{
		super();
		
		this.bmd = Assets.getBitmapData( 'img/sprites.png' );
		
		createAnimation( 'idle', 0, 300, 1, 150, 150 );
		createAnimation( 'walk', 150, 300, 2, 150, 150, 0.2 );
		createAnimation( 'walkaway', 450, 300, 2, 150, 150, 0.2 );
		
		animate('walk');
	}
	
}