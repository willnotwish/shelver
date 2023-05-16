import { Controller } from "@hotwired/stimulus"
import Konva from 'konva'

// Connects to data-controller="unit-preview-canvas"

export default class extends Controller {
  static targets = ['canvas']
  static values = { groups: Array }

  connect() {
    console.log("Controller connecting. Geometry, groups ", this.groupsValue)
    this.stage = new Konva.Stage({
      container: 'unit_preview_container',
      width: this.canvasTarget.clientWidth,
      height: this.canvasTarget.clientHeight
    })

    const layer = new Konva.Layer({name: 'base'})

    const rectDefaults = {
      fill: 'BurlyWood',
      stroke: 'black',
      // strokeWidth: 1,
      opacity: 1,
    }

    const _groupRects = (rectangles, group) => {
      if (rectangles) {
        rectangles.forEach(rect => {
          group.add(new Konva.Rect({...rectDefaults, ...rect}))
        })
      }
    }

    this.groupsValue.forEach(g => {
      const group = new Konva.Group({x: g.x, y: g.y, name: g.name})
      _groupRects(g.rects, group)
      layer.add(group)
    })

    this.stage.add(layer)
  }

  disconnect() {
    console.log("Controller disconnecting")
    this.stage.destroy()
  }
}
