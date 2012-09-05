package org.libra.ui.components {
	import com.greensock.TweenLite;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.libra.ui.base.Component;
	import org.libra.ui.Constants;
	import org.libra.utils.GraphicsUtil;
	
	/**
	 * <p>
	 * 下拉框
	 * </p>
	 *
	 * @class JComboBox
	 * @author Eddie
	 * @qq 32968210
	 * @date 09/05/2012
	 * @version 1.0
	 * @see
	 */
	public class JComboBox extends Component {
		
		private var list:JList;
		
		private var listMask:Shape;
		
		private var content:JLabel;
		
		private var pressBtn:JButton;
		
		private var orientation:int;
		
		private var defaultText:String;
		
		/**
		 * 是否折叠着。。。
		 */
		private var fold:Boolean;
		
		/**
		 * 构造函数
		 * @param	orientation 下拉框方向。默认是4，向下，其他值：向上
		 * @see org.libra.ui.Constants
		 * @param	x
		 * @param	y
		 */
		public function JComboBox(orientation:int = 4, defaultText:String = '', x:int = 0, y:int = 0) { 
			super(x, y);
			this.orientation = orientation;
			this.defaultText = defaultText;
			this.setSize(100, 20);
			fold = true;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function setDataList(val:Vector.<Object>):void {
			list.setDataList(val);
		}
		
		public function getDataList():Vector.<Object> {
			return list.getDataList();
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		override protected function draw():void {
			super.draw();
			
			content = new JLabel(0, 0, defaultText);
			pressBtn = new JButton(0, 0, '', 'vScrollDownBtn');
			pressBtn.setSize(16, 16);
			
			list = new JList();
			listMask = new Shape();
			GraphicsUtil.drawRect(listMask.graphics, 0, 0, 1, 1, 0, 0);
		}
		
		override protected function render():void {
			content.setSize($width, $height);
			this.addChild(content);
			
			pressBtn.setLocation($width - pressBtn.width - 2, ($height - pressBtn.height) >> 1);
			this.addChild(pressBtn);
			list.setSize($width, 160);
			listMask.width = $width;
			listMask.height = list.height;
		}
		
		/**
		 * 展开
		 */
		private function toUnfold():void {
			this.fold = false;
			this.addChild(list);
			this.addChild(listMask);
			list.mask = listMask;
			if (orientation == Constants.DOWN) {
				//加1，让下拉菜单和文本之间留出1像素的空隙，仅仅是为了美观。
				listMask.y = $height + 1;
				list.setLocation(0, listMask.y - list.height);
				
			}else {
				listMask.y = 0 - 1 - listMask.height;
				list.setLocation(0, -1);
			}
			var t:TweenLite = TweenLite.to(list, .2, { y:listMask.y, onComplete:function():void { t.kill(); }} );
		}
		
		/**
		 * 折叠
		 */
		private function toFold():void {
			this.fold = true;
			var t:TweenLite = TweenLite.to(list, .2, { y:orientation == Constants.DOWN ? $height + 1 - list.height : -1, onComplete:function():void { 
					t.kill(); 
					removeChild(list);
					removeChild(listMask);
				}} );
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
		override protected function onAddToStage(e:Event):void {
			super.onAddToStage(e);
			this.pressBtn.addEventListener(MouseEvent.CLICK, onPressClicked);
			this.list.addEventListener(Event.SELECT, onItemSelected);
		}
		
		override protected function onRemoveFromStage(e:Event):void {
			super.onRemoveFromStage(e);
			this.pressBtn.removeEventListener(MouseEvent.CLICK, onPressClicked);
			this.list.removeEventListener(Event.SELECT, onItemSelected);
		}
		
		private function onPressClicked(e:MouseEvent):void {
			fold ? toUnfold() : toFold();
		}
		
		/**
		 * 下拉框点击事件
		 * @param	e
		 */
		private function onItemSelected(e:Event):void {
			var selectedItem:JListItem = list.getSelectedItem();
			this.content.text = selectedItem.getData();
			onPressClicked(null);
		}
		
	}

}