import js.Browser;
import pilot.wings.*;
using pilot.Differ;


class Test {
  
  public static function main() {
    var root = Browser.document.getElementById('root');
    root.patch(new Box({
      children: [
        new PortalTarget({ id: PortalTarget.defaultTarget }),
        new Modal({
          target: PortalTarget.defaultTarget,
          requestClose: () -> trace('close plz'),
          title: 'Test',
          child: new Box({
            children: [ 'test' ]
          })
        })
      ]
    }));
  }

}