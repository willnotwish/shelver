import Konva from 'konva'

class HorizontalRuler {
  constructor(options) {
    this.name = options.name || 'Unnamed ruler'
    this.length = options.length || 1000
    this.majorInterval = options.majorInterval
    this.minorInterval = options.minorInterval
    this.majorTickHeight = options.majorTickHeight
    this.minorTickHeight = options.minorTickHeight
    this.startsAt = options.startsAt || 0
    this.labelFontSize = options.labelFontSize || 28
    this.outline = options.outline
    this.strokeColour = options.lineColour || 'grey'
    this.leadIn = options.leadIn || 20
  }

  boundingWidth() {
    return this.length
  }

  boundingHeight() {
    return this.majorTickHeight
  }

  render(parent) {
    if (this.outline) {
      this.renderOutline(parent)
    }

    // Main axis
    parent.add(
      new Konva.Line({
        points: [-this.leadIn, 0, this.length, 0],
        stroke: this.strokeColour,
        strokeWidth: 4,
      })
    )

    // Tick marks
    const xMax = this.length
    let xMajor = 0
    while (xMajor <= xMax) {
      // Major
      parent.add(
        new Konva.Line({
          points: [0, 0, 0, this.majorTickHeight],
          stroke: this.strokeColour,
          strokeWidth: 4,
          offsetX: -xMajor
        })
      )

      // Label (value)
      const label = new Konva.Text({
        x: xMajor,
        y: 0, 
        text: xMajor,
        fontSize: this.labelFontSize,
        offsetY: 1.5 * this.labelFontSize
      })
      const labelWidth = label.width()
      label.offsetX(labelWidth / 2)
      parent.add(label)

      // Minor ticks
      let xMinor = 0
      while (xMinor < this.majorInterval) {
        const x = xMajor + xMinor
        if (x > xMax) {
          break
        }
        parent.add(
          new Konva.Line({
            points: [0, 0, 0, this.minorTickHeight],
            stroke: this.strokeColour,
            strokeWidth: 4,
            offsetX: -x,
          })
        )
        xMinor += this.minorInterval
      }

      xMajor += this.majorInterval
    }
  }

  renderOutline(parent) {
    const rect = new Konva.Rect({
      width: this.boundingWidth(),
      height: this.boundingHeight(),
      stroke: 'black',
      dash: [4, 4]
    })
    return parent.add(rect)
  }
}

export { HorizontalRuler }
