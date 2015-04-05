package com.ukuleledog.games.evapixel.states;

import com.ukuleledog.games.core.State;
import com.ukuleledog.games.evapixel.elements.Asuka;
import com.ukuleledog.games.evapixel.elements.Rei;
import com.ukuleledog.games.evapixel.elements.Misato;
import com.ukuleledog.games.evapixel.elements.Penpen;
import motion.Actuate;
import motion.easing.Linear;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import openfl.text.Font;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import openfl.ui.Keyboard;

/**
 * ...
 * @author matt
 */
class GameState extends State
{

	private var background:Bitmap;
	private var mur:Bitmap;
	private var asuka:Asuka;
	private var rei:Rei;
	private var misato:Misato;
	private var penpen:Penpen;
	
	private var textFieldAsuka:TextField;
	private var textFieldRei:TextField;
	private var textFieldMisato:TextField;
	private var textFieldShinji:TextField;
	private var textFieldStart:TextField;
	
	private var step:Int;
	
	public function new() 
	{
		super();
		
		background = new Bitmap( Assets.getBitmapData( 'img/background.png' ) );
		background.width = 800;
		background.height = 600;
		
		var murData:BitmapData = new BitmapData( 220, 600 );
		murData.copyPixels( background.bitmapData, new Rectangle( 0, 0, 800, 600 ), new Point() );
		mur = new Bitmap( murData );
		
		asuka = new Asuka();
		asuka.scaleX = 1.2;
		asuka.scaleY = asuka.scaleX;
		asuka.y = 290;
		asuka.x = 400;
		
		rei = new Rei();
		rei.y = 320;
		rei.x = 0;
		
		misato = new Misato();
		misato.scaleX = 1.2;
		misato.scaleY = misato.scaleX;
		misato.y = 290;
		misato.x = 0;
		
		penpen = new Penpen();
		penpen.y = 340;
		penpen.x = 110;
				
		textFieldAsuka = generateTextField( 'asuka' );
		textFieldRei = generateTextField( 'rei' );
		textFieldMisato = generateTextField( 'misato' );
		textFieldShinji = generateTextField( 'shinji' );
		textFieldStart = generateTextField( 'start' );
		
		addEventListener( Event.ADDED_TO_STAGE, init );
	}
	
	private function generateTextField( character:String ) : TextField
	{
		var textField = new TextField();
		textField.width = 400;
		textField.height = 80;
		textField.border = false;
		textField.wordWrap = true;
		textField.multiline = true;
		textField.visible = false;
		
		switch ( character )
		{
			case 'asuka':
				textField.defaultTextFormat = new TextFormat(Assets.getFont("font/pixel.ttf").fontName, 32, 0xFF0000, false, false, false, null, null, TextFormatAlign.CENTER );
				textField.borderColor = 0xFF0000;
				textField.x = 290;
				textField.y = 240;
			case 'rei':
				textField.defaultTextFormat = new TextFormat(Assets.getFont("font/pixel.ttf").fontName, 32, 0x0000FF, false, false, false, null, null, TextFormatAlign.CENTER );
				textField.borderColor = 0x0000FF;
				textField.x = 220;
				textField.y = 270;
			case 'misato':
				textField.defaultTextFormat = new TextFormat(Assets.getFont("font/pixel.ttf").fontName, 32, 0xAA00AA, false, false, false, null, null, TextFormatAlign.CENTER );
				textField.borderColor = 0xAA00AA;
				textField.x = 160;
				textField.y = 240;
			case 'shinji':
				textField.defaultTextFormat = new TextFormat(Assets.getFont("font/pixel.ttf").fontName, 32, 0x0055FF, false, false, false, null, null, TextFormatAlign.CENTER );
				textField.borderColor = 0x0055FF;
				textField.x = 220;
				textField.y = 150;
			case 'start':
				textField.defaultTextFormat = new TextFormat(Assets.getFont("font/pixel.ttf").fontName, 16, 0xFFFFFF, false, false, false, null, null, TextFormatAlign.CENTER );
				textField.width = 100;
				textField.x = 700;
				textField.y = 560;
		}
		
		textField.text = 'hello';
		
		return textField;
	}
	
	private function init( e:Event )
	{
		removeEventListener( Event.ADDED_TO_STAGE, init );
		
		step = 0;
		addChild( background );
		addChild( asuka );
		addChild( rei );
		addChild( misato );
		addChild( penpen );
		addChild( mur );
		
		addChild( textFieldAsuka );
		addChild( textFieldRei );
		addChild( textFieldMisato );
		addChild( textFieldShinji );
		addChild( textFieldStart );
		textFieldStart.text = "Press space";
		
		Actuate.tween( rei, 2, { 'x':350 } ).ease( Linear.easeNone).onComplete( function() {
			rei.setAnimation( 'idle' );
			nextStep();
		} );
	}
	
	private function onKeyDown( e:KeyboardEvent )
	{
		if ( e.keyCode == Keyboard.SPACE )
			nextStep();
	}
	
	private function listenToKeyboard()
	{
		stage.addEventListener( KeyboardEvent.KEY_DOWN, nextStep );
		textFieldStart.visible = true;
	}
	
	private function stopListenToKeyboard()
	{
		stage.removeEventListener( KeyboardEvent.KEY_DOWN, nextStep );
		textFieldStart.visible = false;
	}
	
	private function nextStep( e:KeyboardEvent = null )
	{
		stopListenToKeyboard();
		
		switch( step )
		{
			case 0:
				textFieldRei.text = 'Hey bitch.';
				textFieldRei.visible = true;
				listenToKeyboard();
			case 1:
				textFieldRei.visible = false;
				textFieldAsuka.text = 'Hey nerd.';
				textFieldAsuka.visible = true;
				listenToKeyboard();
			case 2:
				textFieldAsuka.visible = false;
				textFieldRei.text = 'Misato is waiting for us.';
				textFieldRei.visible = true;
				listenToKeyboard();
			case 3:
				textFieldRei.text = 'Have you seen Shinji?';
				listenToKeyboard();
			case 4:
				textFieldRei.visible = false;
				textFieldAsuka.text = 'Nope.';
				textFieldAsuka.visible = true;
				listenToKeyboard();
			case 5:
				textFieldAsuka.text = 'He must be in the shower with some dude.';
				listenToKeyboard();
			case 6:
				textFieldAsuka.text = 'Lol';
				textFieldRei.text = 'Lol';
				textFieldRei.visible = true;
				listenToKeyboard();
			case 7:
				textFieldAsuka.visible = false;
				textFieldRei.visible = false;
				Actuate.tween( misato, 2, { 'x': 260 } ).ease( Linear.easeNone).onComplete( function() {
					misato.setAnimation('idle');
					textFieldMisato.text = "Hey girls. You're late.";
					textFieldMisato.visible = true;
					listenToKeyboard();
				} );
			case 8:
				textFieldMisato.visible = false;
				textFieldAsuka.text = "Yeah yeah we're coming.";
				textFieldAsuka.visible = true;
				listenToKeyboard();
			case 9:
				textFieldAsuka.visible = false;
				textFieldMisato.text = "Where's Shinji ?";
				textFieldMisato.visible = true;
				listenToKeyboard();
			case 10:
				textFieldMisato.visible = false;
				textFieldAsuka.visible = false;
				textFieldRei.text = 'In Kaoru.';
				textFieldRei.visible = true;
				listenToKeyboard();
			case 11:
				textFieldAsuka.text = 'Lol';
				textFieldRei.text = 'Lol';
				textFieldMisato.text = 'Lol';
				textFieldAsuka.visible = true;
				textFieldMisato.visible = true;
				listenToKeyboard();
			case 12:
				textFieldAsuka.visible = false;
				textFieldRei.visible = false;
				textFieldMisato.text = "Too bad for him, we're doing nude training today again.";
				listenToKeyboard();
			case 13:
				textFieldMisato.text = "Let's go.";
				listenToKeyboard();
			case 14:
				textFieldMisato.visible = false;
				misato.setAnimation('walkaway');
				asuka.setAnimation('walkaway');
				rei.setAnimation('walkaway');
				Actuate.tween( misato, 2, { 'x': 0 } ).ease( Linear.easeNone);
				Actuate.tween( asuka, 2, { 'x': 70 } ).ease( Linear.easeNone);
				Actuate.tween( rei, 2, { 'x': 90 } ).ease( Linear.easeNone).onComplete( function() {
					removeChild( misato );
					removeChild( rei );
					removeChild( asuka );
					textFieldShinji.text = 'Hello?';
					textFieldShinji.visible = true;
					listenToKeyboard();
				});
			case 15:
				textFieldShinji.text = 'Is there anybody out there?';
				listenToKeyboard();
			case 16:
				textFieldShinji.text = 'Asuka locked me in here.';
				listenToKeyboard();
			case 17:
				textFieldShinji.visible = false;
				Actuate.tween( penpen, 1, { 'x': 160 } ).ease( Linear.easeNone).onComplete( function() {
					textFieldShinji.visible = true;
					textFieldShinji.text = 'Anyone?';
					listenToKeyboard();
				});
			case 18:
				textFieldShinji.text = 'Whoever you are, I can hear you.';
				listenToKeyboard();
			case 19:
				textFieldShinji.visible = false;
				Actuate.tween( penpen, 1, { 'x': 100 } ).ease( Linear.easeNone).onComplete( function() {
					textFieldShinji.visible = true;
					textFieldShinji.text = 'Get me out!';
					listenToKeyboard();
					removeChild( penpen );
					removeChild( mur );
				});
			case 20:
				textFieldShinji.text = 'Daddy? Is that you?';
				listenToKeyboard();
			case 21:
				textFieldShinji.text = 'Daddy?';
				listenToKeyboard();	
			case 22:
				textFieldShinji.text = 'Daddy !!!';
				Actuate.tween( this, 2, { 'alpha': 0 } ).ease( Linear.easeNone).onComplete( function() {
					textFieldShinji.visible = false;
					removeChild( background );
					nextStep();
				});
			case 23:
				textFieldStart.text = 'The end.';
				textFieldStart.visible = true;
				Actuate.tween( this, 2, { 'alpha': 1 } );
		}
		
		step++;
	}
	
}