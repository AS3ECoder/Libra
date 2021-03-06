package org.libra.ui.flash.core.state {
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import org.libra.ui.flash.theme.Skin;
	import org.libra.utils.displayObject.GraphicsUtil;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class BaseListItemState
	 * @author Eddie
	 * @qq 32968210
	 * @date 09-03-2012
	 * @version 1.0
	 * @see
	 */
	public class BaseListItemState extends Shape implements ISelectState {
		
		private var _selected:Boolean;
		
		private var _width:int;
		
		private var _height:int;
		
		public function BaseListItemState() {
			super();
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/* INTERFACE org.libra.ui.base.stateus.interfaces.ISelectStatus */
		
		public function set selected(val:Boolean):void {
			this._selected = val;
			val ? toSelected() : toNormal();
		}
		
		public function toSelected():void {
			GraphicsUtil.drawRect(this.graphics, 0, 0, _width, _height, Skin.LIST_SELECTED);
		}
		
		public function setSize(w:int, h:int):void {
			this._width = w;
			this._height = h;
		}
		
		public function set skin(val:String):void {
			
		}
		
		public function get displayObject():DisplayObject {
			return this;
		}
		
		public function toNormal():void {
			_selected ? toSelected() : GraphicsUtil.drawRect(this.graphics, 0, 0, _width, _height, Skin.LIST_DEFAULT);
		}
		
		public function toMouseOver():void {
			GraphicsUtil.drawRect(this.graphics, 0, 0, _width, _height, Skin.LIST_ROLLOVER);
		}
		
		public function toMouseDown():void {
			
		}
		
		public function dispose():void {
			
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}