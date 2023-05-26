import { Controller } from "@hotwired/stimulus"
import Konva from 'konva'


function rulers({xLimit, yLimit}) {
  console.log("xLimit, yLimit", xLimit, yLimit)
  const xRuler = new Konva.Line({
    points: [0, 0, xLimit, 0],
    stroke: 'red',
    strokeWidth: 10,
    lineCap: 'round',
    lineJoin: 'round',
  })

  const yRuler = new Konva.Line({
    points: [0, 0, 0, yLimit],
    stroke: 'red',
    strokeWidth: 10,
    lineCap: 'round',
    lineJoin: 'round',
  })

  return [xRuler, yRuler]
}

// Connects to data-controller="unit-preview-canvas"

export default class extends Controller {
  static targets = ['canvas']
  static values = { groups: Array, scale: Number, boundingBox: Object }

  connect() {
    console.log("Bounding box:", this.boundingBoxValue)
    this.stage = new Konva.Stage({
      container: 'unit_preview_container',
      width: this.canvasTarget.clientWidth,
      height: this.canvasTarget.clientHeight,
      scaleX: this.scaleValue,
      scaleY: this.scaleValue,
      // offsetX: -50,
      // offsetY: -50
    })

    const rectDefaults = {
      fill: 'BurlyWood',
      stroke: 'black'
    }

    const boundingBoxDefaults = {
      fill: 'Gainsboro',
      stroke: 'red'
    }

    const _groupRects = (rectangles, group) => {
      if (rectangles) {
        rectangles.forEach(rect => {
          group.add(new Konva.Rect({...rectDefaults, ...rect}))
        })
      }
    }

    const layer = new Konva.Layer()
    this.stage.add(layer)

    // Draw bounding box
    const bounds = this.boundingBoxValue
    // layer.add(new Konva.Rect({...boundingBoxDefaults, ...bounds.rect}))

    const xRulerHeight = 180
    const yRulerWidth = 100
    const xRulerExtension = 80
    const yRulerExtension = 80

    // Create groups and lay them out
    const xRulerGroup = new Konva.Group({
      name: 'x-ruler group',
      x: 0,
      y: 0,
      width: bounds.rect.width + yRulerWidth + xRulerExtension,
      height: xRulerHeight
    })

    const horizontalRule = new Konva.Group({
      width: bounds.rect.width,
      height: 40, // major tick height
      offsetY: -xRulerGroup.height() / 2,
      offsetX: -yRulerWidth
    })

    // horizontalRule.add(
    //   new Konva.Rect({
    //     x: 0, 
    //     y: 0,
    //     width: horizontalRule.width(),
    //     height: horizontalRule.height(),
    //     stroke: 'black',
    //     dash: [1, 1]
    //   })
    // )

    horizontalRule.add(
      new Konva.Line({
        points: [0, 0, horizontalRule.width(), 0],
        stroke: 'grey',
        strokeWidth: 8,
        offsetY: -horizontalRule.height() / 2
      })
    )

    const majorInterval = 200
    const minorInterval = 50
    const xMax = horizontalRule.width()
    const majorTickHeight = horizontalRule.height()
    const minorTickHeight = majorTickHeight / 2
    const labelFontSize = 28

    let xMajor = 0
    while (xMajor <= xMax) {
      horizontalRule.add(
        new Konva.Line({
          points: [0, 0, 0, majorTickHeight],
          stroke: 'grey',
          strokeWidth: 4,
          offsetX: -xMajor
        })
      )

      const label = new Konva.Text({
        x: xMajor,
        y: 0, 
        text: xMajor,
        fontSize: labelFontSize,
        offsetY: 1.2 * labelFontSize
      })
      const labelWidth = label.width()
      label.offsetX(labelWidth / 2)

      horizontalRule.add(label)

      let xMinor = 0
      while (xMinor < majorInterval) {
        const x = xMajor + xMinor
        if (x > xMax) {
          break
        }
        horizontalRule.add(
          new Konva.Line({
            points: [0, 0, 0, minorTickHeight],
            stroke: 'grey',
            strokeWidth: 4,
            offsetX: -x,
            offsetY: - horizontalRule.height() / 4
          })
        )
        xMinor += minorInterval
      }

      xMajor += majorInterval
    }

    xRulerGroup.add(horizontalRule)

    // let x = 0
    // const majorInterval = 100
    // const xMax = bounds.rect.width
    // while (x < xMax) {
    //   let tick = new Konva.Line({
    //     points: [0, -10, 0, 10],
    //     stroke: 'black',
    //     strokeWidth: 3,
    //     offsetY: -xRulerGroup.height() / 2,
    //     offsetX: -yRulerWidth - x
    //   })
    //   xRulerGroup.add(tick)
    //   x += majorInterval
    // }

    // const yRulerGroup = new Konva.Group({
    //   name: 'y-ruler group',
    //   x: 0,
    //   y: 0,
    //   width: yRulerWidth,
    //   height: bounds.rect.height + xRulerHeight + yRulerExtension
    // })

    // const xPos = yRulerGroup.width() / 2
    // const yRule = new Konva.Line({
    //   points: [xPos, 0, xPos, yRulerGroup.height()],
    //   stroke: 'black',
    //   strokeWidth: 4
    // })
    // // yRulerGroup.add(yRule)

    const mainGroup = new Konva.Group({
      name: 'main group',
      x: yRulerWidth,
      y: xRulerHeight,
      width: bounds.rect.width,
      height: bounds.rect.height
    })

    this.groupsValue.forEach(g => {
      const unitGroup = new Konva.Group({
        x: g.x,
        y: g.y,
        name: g.name,
      })
      _groupRects(g.rects, unitGroup)
      // if (g.name) {
      //   const simpleLabel = new Konva.Text({
      //     x: g.x + 50,
      //     y: g.y,
      //     text: g.name,
      //     fontSize: 32
      //   })
      //   layer.add(simpleLabel)
      // }
      mainGroup.add(unitGroup)
    })

    const topLevelGroups = [xRulerGroup, mainGroup]
    topLevelGroups.forEach(group => layer.add(group))
  }

  disconnect() {
    this.stage.destroy()
  }
}
