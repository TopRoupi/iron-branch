import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "tree" ]

  zoomIn(event){
    $(this.treeTarget).css('transform', `scale(${this.zoom += 0.1})`);
  }

  zoomOut(event){
    $(this.treeTarget).css('transform', `scale(${this.zoom -= 0.1})`);
  }

  zoomReset(event){
    $(this.treeTarget).css('transform', `scale(${this.zoom = 1})`);
  }

  connect() {
    this.zoom = 1
    $(this.treeTarget).draggable()
  }
}