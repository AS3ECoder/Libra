/*
 * Copyright 2013 Krecha Games (www.krecha-games.com)
 */

/**
 * Created with IntelliJ IDEA.
 * User: swiezy
 * Date: 18.12.2012
 * Time: 13:46
 */
package com.krechagames.utils.assets.loaders {
	import com.krechagames.utils.assets.Asset;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.media.Sound;
	import flash.net.URLRequest;

	public class SoundAsset extends Asset {
		protected var loader:Sound;

		public function SoundAsset(id:String = null, url:String = null, group:String = null) {
			super(id, url, group);

			loader = new Sound();
		}

		protected function loadEventHandler(event:Event):void {
			dispatchEvent(event);
		}

		override public function load(version:int = 0):void {
			loader.addEventListener(Event.COMPLETE, loadEventHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, loadEventHandler);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loadEventHandler);
			loader.addEventListener(ProgressEvent.PROGRESS, loadEventHandler);

			loader.load(new URLRequest(url + "?v="+version));
		}

		override public function dispose():void {
			loader.removeEventListener(Event.COMPLETE, loadEventHandler);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, loadEventHandler);
			loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, loadEventHandler);
			loader.removeEventListener(ProgressEvent.PROGRESS, loadEventHandler);

			try {
				loader.close();
			}catch(e:Error){}

			loader = null;

			dispatchEvent(new Event(Event.REMOVED))
		}

		public function get castSound():Sound {
			return loader;
		}
	}
}
