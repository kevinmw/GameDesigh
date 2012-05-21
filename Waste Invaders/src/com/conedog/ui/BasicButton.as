/*	BLOC Lib for ActionScript 3.0	Copyright (c) 2009, The Bloc Development Team*/package com.conedog.ui 
{	import com.conedog.events.BasicButtonEvent;	import flash.display.MovieClip;	import flash.display.Sprite;	import flash.events.MouseEvent;	/*	This is an abstract class for a generic button. It save you having to recreate		button logic and lets you focus on the fun parts of making a button				@author Mat Groves		@version 03/01/09		@example			<code>				package {					import com.bloc.tweener.Tweener;					import com.bloc.ui.BasicButton;											public class BigButton extends BasicButton					{							public function BigButton()							{								super();							}														override public function over():void							{								Tweener.tween(this, "alpha", 0.5, 0.3, "easeInSine");							}														override public function out():void							{								Tweener.tween(this, "alpha", 1, 0.3, "easeInSine");							}														override public function up():void							{								Tweener.tween(this, "rotation", 0, 3, "easeOutElastic");							}														override public function down():void							{								Tweener.tween(this, "rotation", 180, 0.3, "easeInSine");							}					}				}			</code>	*/ 	public class BasicButton extends MovieClip	{		// E V E N T S --------------------------------------------//					// P R O P E R T I E S ------------------------------------//						private var _enabled			:Boolean = true;		private var _hitZone			:Sprite;				private var isMouseDown			:Boolean = false;				// G E T T E R S / S E T T E R S --------------------------//				/* 			Sets if the button is enabled or not. The button will not dispatch			any events or show the mouse hand icon when this is set to false		*/		override public function set enabled(b:Boolean):void		{						//if(_enabled == b)return;						_enabled = b;						if(_enabled)			{				this._hitZone.mouseChildren = false;				this._hitZone.mouseEnabled = true;				this._hitZone.buttonMode = true;				onEnabled();			}			else			{				_hitZone.mouseChildren = false;				_hitZone.mouseEnabled = false;				_hitZone.buttonMode = false;				onDisabled();			}					}				/*			Indicates if the button is enabled or not		*/		override public function get enabled():Boolean		{			return _enabled;		}				/*			Sets the hit zone for the button						Note: the HitZone is the area that listens to all the events for the button			by default the hit zone is the button itself		*/		public function set hitZone(target:Sprite):void		{			if(_hitZone == target)return;						_hitZone.mouseChildren = true;			_hitZone.mouseEnabled = false;			_hitZone.buttonMode = false;						_hitZone.removeEventListener(MouseEvent.ROLL_OVER, onBtOver);			_hitZone.removeEventListener(MouseEvent.ROLL_OUT, onBtOut);			_hitZone.removeEventListener(MouseEvent.MOUSE_DOWN, onBtDown);						_hitZone = target;						_hitZone.addEventListener(MouseEvent.MOUSE_DOWN, onBtDown, false, 0, true);			_hitZone.addEventListener(MouseEvent.ROLL_OVER, onBtOver, false, 0, true);			_hitZone.addEventListener(MouseEvent.ROLL_OUT, onBtOut, false, 0, true);								this._hitZone.mouseChildren = false;			this._hitZone.mouseEnabled = true;			this._hitZone.buttonMode = true;								}						/*			returns buttons current hit zone		*/		public function get hitZone():Sprite		{			return _hitZone;		}						// C O N S T R U C T O R ----------------------------------//				/*			Creates a new basic button						@param: _hitZone: the hit zone for the button (by defalt the button will be its own  hit zone		*/		public function BasicButton(_hitZone:Sprite = null)		{			this._hitZone = (_hitZone) ? _hitZone : this;						this._hitZone.addEventListener(MouseEvent.MOUSE_DOWN, onBtDown, false, 0, true);					this._hitZone.addEventListener(MouseEvent.ROLL_OVER, onBtOver, false, 0, true);			this._hitZone.addEventListener(MouseEvent.ROLL_OUT, onBtOut, false, 0, true);									this._hitZone.mouseChildren = false;			this._hitZone.mouseEnabled = true;			this._hitZone.buttonMode = true;			//mouseChildren = true;			//mouseEnabled = true;			//buttonMode = true;			}					// P U B L I C --------------------------------------------//				/*			This funciton is called when the button is rolled over		*/		public function over():void		{			// overide me :)		}				/*			This funciton is called when the button is rolled out		*/		public function out():void		{			// overide me :)		}				/*			This funciton is called when the button is released		*/		public function up():void		{			// overide me :)		}				/*			This funciton is called when the button is pressed		*/		public function down():void		{			// overide me :)		}				public function clicked():void		{			// overide me :)		}				/*			This funciton is called when the button is pressed		*/		public function onEnabled():void		{			// overide me :)		}				public function onDisabled():void		{			// overide me :)		}				// P R O T E C T E D---------------------------------------//		// P R I V A T E ------------------------------------------//		// H A N D L E R S ----------------------------------------//				private function onBtOver(e:MouseEvent):void		{			//isMouseDown ? down() : 						over();		}				private function onBtOut(e:MouseEvent):void		{		//	isMouseDown ? () : 						//if(!isMouseDown)			out();		}				private function onBtUp(e:MouseEvent):void		{			isMouseDown = false;						if(stage)stage.removeEventListener(MouseEvent.MOUSE_UP, onBtUp);			_hitZone.removeEventListener(MouseEvent.MOUSE_UP, onBtUp);						up();			clicked();			dispatchEvent(new BasicButtonEvent(BasicButtonEvent.ON_CLICK, this));			}				private function onBtUpOutside(e:MouseEvent):void		{			isMouseDown = false;						if(stage)stage.removeEventListener(MouseEvent.MOUSE_UP, onBtUpOutside);			_hitZone.removeEventListener(MouseEvent.MOUSE_UP, onBtUp);						up();			}				private function onBtDown(e:MouseEvent):void		{			isMouseDown = true;						if(stage)stage.addEventListener(MouseEvent.MOUSE_UP, onBtUpOutside, false, 0, true);			_hitZone.addEventListener(MouseEvent.MOUSE_UP, onBtUp, false, 0, true);						down();		}	}}