#' Draw a smiley face
#'
#' Uses \code{\link[grid]{Grid}} graphics to draw a face.
#'
#' @param x horizontal position
#' @param y vertical position
#' @param size area of the face
#' @param colour colour of outlines and features
#' @param fill fill colour
#' @param alpha transparency, where 0 is transparent and 1 is opaque
#' @param smile amount of smiling/frowning
#' @param brow eyebrow angle, to represent anger or concern
#' @param nose logical. Adds a nose to the face
#' @param eyes distance between the eyes
#'
#' @return A \code{\link[grid]{grobTree}} object.
#'
#' @seealso \code{\link{geom_chernoff}}
#'
#' @import grid
#' @export
#'
#' @examples
#' face <- chernoffGrob(0.5, 0.5, size = 1e3, smile = -1, brow = 1, colour = 'navy', fill = 'lightblue')
#' grid::grid.newpage()
#' grid::grid.draw(face)
chernoffGrob <- function(
  x = 0.5,
  y = 0.5,
  size = 1,
  colour = 'black',
  fill = NA,
  alpha = 1,
  smile = 1,
  brow = NA,
  nose = FALSE,
  eyes = 1
) {
  .pt <- 72.27 / 25.4
  faceGrob <- circleGrob(x, y, r = unit(sqrt(0.5 * size * .pt), 'mm'))
  vp1 <- viewport(
    x = x,
    y = y,
    width = grobWidth(faceGrob),
    height = grobHeight(faceGrob)
  )
  eyesGrob <- circleGrob(
    rep(0.5 + eyes * c(-0.2, +0.2), each = length(x)),
    0.6,
    r = 1 / 20,
    gp = gpar(fill = colour),
    vp = vp1
  )
  if (!is.na(brow)) {
    browGrob <- polylineGrob(
      x = c(0.2, 0.4, 0.6, 0.8),
      y = 0.75 + brow * c(+0.05, -0.05, -0.05, +0.05), # .7--.8
      id = rep(1:2, each = 2),
      gp = gpar(col = colour),
      vp = vp1
    )
  } else {
    browGrob <- nullGrob()
  }
  noseGrob <- circleGrob(
    r = 1 / 15,
    gp = gpar(col = ifelse(nose, colour, NA), fill = NA),
    vp = vp1
  )
  mouthGrob <- bezierGrob(
    rep(0.5, each = 4) + c(-0.25, -0.1, 0.1, 0.25),
    rep(0.28, each = 4) + smile * c(0.08, -0.12, -0.12, 0.08),
    gp = gpar(fill = colour),
    id.lengths = rep(4, length(x)),
    vp = vp1
  )
  grobTree(
    faceGrob,
    noseGrob,
    eyesGrob,
    browGrob,
    mouthGrob,
    gp = gpar(alpha = alpha, col = colour, fill = fill)
  )
}
