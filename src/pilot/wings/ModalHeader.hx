package pilot.wings;

import pilot.Component;
import pilot.Style;

class ModalHeader extends Component {

  @:attribute @:optional var style:Style;
  @:attribute var title:String;
  @:attribute var requestClose:()->Void;
  @:attribute @:optional var icon:RenderResult;

  override function render() return html(
    <header class={style}>
      <h2>{title}</h2>
      <button onClick={_ -> requestClose()}>
        <if {icon != null}>
          {icon}
        <else>
          X
        </if>
      </button>
    </header>
  );

}
