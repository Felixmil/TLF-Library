#' @title .addScatterLayer
#' @description Add scatter points layer of a molecule plot
#' @param plotObject A `ggplot` object
#' @param data A data.frame with labels mapped to properties and obtained from a `DataMapping` object
#' @param mapLabels List of mapped label names passed to `ggplot2::aes`
#' @return A `ggplot` object
#' @keywords internal
.addScatterLayer <- function(plotObject, data, mapLabels) {
  aestheticValues <- .getAestheticValuesFromConfiguration(
    n = 1,
    position = 0,
    plotConfigurationProperty = plotObject$plotConfiguration$points,
    propertyNames = c("size", "alpha")
  )

  plotObject <- plotObject +
    geomTLFPoint(
      data = data,
      mapping = ggplot2::aes(
        x = .data[[mapLabels$x]],
        y = .data[[mapLabels$y]],
        color = .data[[mapLabels$color]],
        shape = .data[[mapLabels$shape]],
        alpha = if (mapLabels$lloq != "legendLabels") {
          .data[[mapLabels$y]] > .data[[mapLabels$lloq]]
        } else {
          as.factor(aestheticValues$alpha)
        }
      ),
      size = aestheticValues$size,
      na.rm = TRUE,
      show.legend = TRUE
    ) +
    scale_alpha_manual(
      values = if (mapLabels$lloq != "legendLabels") {
        # ensure that no matter the alpha setting is, the computed level is between 0 and
        c(0.618*aestheticValues$alpha, aestheticValues$alpha)
      } else {
        aestheticValues$alpha
      },
      breaks = NULL
    )
  return(plotObject)
}

#' @title .addErrorbarLayer
#' @description Add errorbar layer of a molecule plot
#' @param plotObject A `ggplot` object
#' @param data A data.frame with labels mapped to properties and obtained from a `DataMapping` object
#' @param mapLabels List of mapped label names passed to `ggplot2::aes_string`
#' @return A `ggplot` object
#' @keywords internal
.addErrorbarLayer <- function(plotObject, data, mapLabels, direction = "vertical") {
  aestheticValues <- .getAestheticValuesFromConfiguration(
    n = 1,
    position = 0,
    plotConfigurationProperty = plotObject$plotConfiguration$errorbars,
    propertyNames = c("size", "linetype", "alpha")
  )

  plotObject <- switch(direction,
    "vertical" = plotObject +
      ggplot2::geom_linerange(
        data = data,
        mapping = ggplot2::aes(
          x = .data[[mapLabels$x]],
          # If lower value is negative and plot is log scaled,
          # Upper bar will still be plotted
          ymin = .data[[mapLabels$ymin]],
          ymax = .data[[mapLabels$y]],
          color = .data[[mapLabels$color]],
          group = .data[[mapLabels$shape]]
        ),
        size = aestheticValues$size,
        linetype = aestheticValues$linetype,
        alpha = aestheticValues$alpha,
        na.rm = TRUE,
        show.legend = FALSE
      ) +
      ggplot2::geom_linerange(
        data = data,
        mapping = ggplot2::aes(
          x = .data[[mapLabels$x]],
          # If lower value is negative and plot is log scaled,
          # Upper bar will still be plotted
          ymin = .data[[mapLabels$y]],
          ymax = .data[[mapLabels$ymax]],
          color = .data[[mapLabels$color]],
          group = .data[[mapLabels$shape]]
        ),
        size = aestheticValues$size,
        linetype = aestheticValues$linetype,
        alpha = aestheticValues$alpha,
        na.rm = TRUE,
        show.legend = FALSE
      ) +
      # Add lower cap to error bar
      # If lower value is negative and plot is log scaled,
      # Upper bar cap will still be plotted
      ggplot2::geom_point(
        data = data,
        mapping = ggplot2::aes(
          x = .data[[mapLabels$x]],
          y = .data[[mapLabels$ymin]],
          color = .data[[mapLabels$color]],
          group = .data[[mapLabels$shape]]
        ),
        size = tlfEnv$defaultErrorbarCapSize,
        shape = "_",
        alpha = aestheticValues$alpha,
        na.rm = TRUE,
        show.legend = FALSE
      ) +
      # Add upper cap to error bar
      # If lower value is negative and plot is log scaled,
      # Upper bar cap will still be plotted
      ggplot2::geom_point(
        data = data,
        mapping = ggplot2::aes(
          x = .data[[mapLabels$x]],
          y = .data[[mapLabels$ymax]],
          color = .data[[mapLabels$color]],
          group = .data[[mapLabels$shape]]
        ),
        size = tlfEnv$defaultErrorbarCapSize,
        shape = "_",
        alpha = aestheticValues$alpha,
        na.rm = TRUE,
        show.legend = FALSE
      ),
    "horizontal" = plotObject +
      ggplot2::geom_linerange(
        data = data,
        mapping = ggplot2::aes(
          # If lower value is negative and plot is log scaled,
          # Upper bar will still be plotted
          xmin = .data[[mapLabels$xmin]],
          xmax = .data[[mapLabels$x]],
          y = .data[[mapLabels$y]],
          color = .data[[mapLabels$color]],
          group = .data[[mapLabels$shape]]
        ),
        size = aestheticValues$size,
        linetype = aestheticValues$linetype,
        alpha = aestheticValues$alpha,
        na.rm = TRUE,
        show.legend = FALSE
      ) +
      ggplot2::geom_linerange(
        data = data,
        mapping = ggplot2::aes(
          # If lower value is negative and plot is log scaled,
          # Upper bar will still be plotted
          xmin = .data[[mapLabels$x]],
          xmax = .data[[mapLabels$xmax]],
          y = .data[[mapLabels$y]],
          color = .data[[mapLabels$color]],
          group = .data[[mapLabels$shape]]
        ),
        size = aestheticValues$size,
        linetype = aestheticValues$linetype,
        alpha = aestheticValues$alpha,
        na.rm = TRUE,
        show.legend = FALSE
      ) +
      # Add lower cap to error bar
      # If lower value is negative and plot is log scaled,
      # Upper bar cap will still be plotted
      ggplot2::geom_point(
        data = data,
        mapping = ggplot2::aes(
          x = .data[[mapLabels$xmin]],
          y = .data[[mapLabels$y]],
          color = .data[[mapLabels$color]],
          group = .data[[mapLabels$shape]]
        ),
        size = tlfEnv$defaultErrorbarCapSize,
        shape = "|",
        alpha = aestheticValues$alpha,
        na.rm = TRUE,
        show.legend = FALSE
      ) +
      # Add upper cap to error bar
      # If lower value is negative and plot is log scaled,
      # Upper bar cap will still be plotted
      ggplot2::geom_point(
        data = data,
        mapping = ggplot2::aes(
          x = .data[[mapLabels$xmax]],
          y = .data[[mapLabels$y]],
          color = .data[[mapLabels$color]],
          group = .data[[mapLabels$shape]]
        ),
        size = tlfEnv$defaultErrorbarCapSize,
        shape = "|",
        alpha = aestheticValues$alpha,
        na.rm = TRUE,
        show.legend = FALSE
      )
  )
  return(plotObject)
}

#' @title .addLineLayer
#' @description Add line layer of a molecule plot
#' @param plotObject A `ggplot` object
#' @param type one of "horizontal", "vertical" or "diagonal"
#' Note that for "diagonal", geom_abline is used.
#' `value` of intercept is taken as is for linear scale but corresponds to the log of `value` for log scale.
#'  For instance, intercept = c(-1, 0, 1) with log scale actually means that the line will go through c(0.1, 1, 10)
#'  because c(-1, 0, 1) = log10(c(0.1, 1, 10)).
#' @param value value of xintercept or yintercept
#' @param position line position for aesthetic properties
#' @return A `ggplot` object
#' @keywords internal
.addLineLayer <- function(plotObject, type, value, position) {
  aestheticValues <- .getAestheticValuesFromConfiguration(
    n = 1,
    position = position,
    plotConfigurationProperty = plotObject$plotConfiguration$lines,
    propertyNames = c("color", "linetype", "size", "alpha")
  )

  plotObject <- plotObject + switch(type,
    "horizontal" = ggplot2::geom_hline(
      yintercept = value,
      color = aestheticValues$color,
      linetype = aestheticValues$linetype,
      alpha = aestheticValues$alpha,
      size = aestheticValues$size
    ),
    "vertical" = ggplot2::geom_vline(
      xintercept = value,
      color = aestheticValues$color,
      linetype = aestheticValues$linetype,
      alpha = aestheticValues$alpha,
      size = aestheticValues$size
    ),
    "diagonal" = ggplot2::geom_abline(
      slope = 1,
      intercept = value,
      linetype = aestheticValues$linetype,
      color = aestheticValues$color,
      alpha = aestheticValues$alpha,
      size = aestheticValues$size
    ),
    "obsvspredDiagonal" = ggplot2::geom_abline(
      data = data.frame(
        value = value,
        position = as.character(position),
        slope = 1
      ),
      aes(
        intercept = .data$value,
        linetype = .data$position,
        slope = .data$slope
      ),
      color = aestheticValues$color,
      alpha = aestheticValues$alpha,
      size = aestheticValues$size,
      key_glyph = plotObject$plotConfiguration$foldLineslegendType
    ),
    "ddiHorizontal" = ggplot2::geom_abline(
      slope = 0,
      intercept = value,
      color = aestheticValues$color,
      linetype = aestheticValues$linetype,
      alpha = aestheticValues$alpha,
      size = aestheticValues$size
    )
  )
  return(plotObject)
}

#' @title getDualAxisPlot
#' @description Check if dual Y Axis is needed
#' @param leftPlotObject A `ggplot` object with left y-axis
#' @param rightPlotObject A `ggplot` object with right y-axis
#' @return A `ggplot` object with dual y-axis
#' @export
getDualAxisPlot <- function(leftPlotObject, rightPlotObject) {
  stopifnot(requireNamespace("cowplot", quietly = TRUE))
  # Only one legend shall be kept to prevent text not aligned and on top of plot axes text
  # For most cases, right plot legend is kept as is while left plot legend is removed
  # If left side legend, left plot legend is kept as is while right plot legend is removed
  legendPosition <- getLegendPosition(leftPlotObject)
  if (isIncluded(legendPosition, LegendPositions$outsideLeft)) {
    rightPlotObject <- setLegendPosition(rightPlotObject, position = LegendPositions$none)
  } else {
    leftPlotObject <- setLegendPosition(leftPlotObject, position = LegendPositions$none)
  }
  # Set same X-Axis between plots
  leftScale <- ggplot2::layer_scales(leftPlotObject)
  rightScale <- ggplot2::layer_scales(rightPlotObject)
  mergeXRange <- range(leftScale$x$range$range, rightScale$x$range$range)

  leftPlotObject <- setXAxis(leftPlotObject, limits = mergeXRange)
  rightPlotObject <- setXAxis(rightPlotObject, limits = mergeXRange)

  # Transformed right plot to be compatible with left plot
  rightPlotObject <- rightPlotObject +
    ggplot2::theme(
      # Update right axis properties
      axis.text.y.right = rightPlotObject$plotConfiguration$y2Axis$font$createPlotFont(),
      axis.title.y.right = rightPlotObject$plotConfiguration$labels$y2label$createPlotFont(),
      axis.line.y.right = rightPlotObject$plotConfiguration$background$y2Axis$createPlotElement(),
      panel.grid.major.y = rightPlotObject$plotConfiguration$background$y2Grid$createPlotElement(),
      panel.grid.minor.y = rightPlotObject$plotConfiguration$background$y2Grid$createPlotElement(
        size = as.numeric(rightPlotObject$plotConfiguration$background$y2Grid$size) / 2
      ),
      # Remove all other background properties
      plot.background = ggplot2::element_blank(),
      panel.background = ggplot2::element_blank(),
      axis.line.x = ggplot2::element_blank(),
      axis.line.y.left = ggplot2::element_blank(),
      panel.grid.major.x = ggplot2::element_blank(),
      panel.grid.minor.x = ggplot2::element_blank()
    )
  rightPlotObject <- setPlotLabels(
    rightPlotObject,
    ylabel = rightPlotObject$plotConfiguration$labels$y2label
  )
  rightPlotObject <- setY2Axis(rightPlotObject)
  leftPlotObject <- setYAxis(leftPlotObject)

  alignedPlots <- cowplot::align_plots(
    leftPlotObject,
    rightPlotObject,
    align = "hv",
    axis = "tblr"
  )

  mergedPlotObject <- cowplot::ggdraw(alignedPlots[[1]]) +
    cowplot::draw_plot(alignedPlots[[2]])
  # In case of additional updates, clone plotConfiguration
  mergedPlotObject$plotConfiguration <- leftPlotObject$plotConfiguration$clone(deep = TRUE)

  return(mergedPlotObject)
}

#' @title .addLLOQLayer
#' @description Add a line layer representing the Lower Limit Of Quantification (LLOQ)
#' @param plotObject A `ggplot` object
#' @param data A data.frame with labels mapped to properties and obtained from a `DataMapping` object
#' @param mapLabels List of mapped label names passed to `ggplot2::aes_string`
#' @return A `ggplot` object
#' @keywords internal
.addLLOQLayer <- function(plotObject, data, mapLabels) {
  aestheticValues <- .getAestheticValuesFromConfiguration(
    n = 1,
    position = 0,
    plotConfigurationProperty = plotObject$plotConfiguration$lines,
    propertyNames = c("color", "linetype", "size", "alpha")
  )

  plotObject <- plotObject +
    ggplot2::geom_hline(
      data = data,
      mapping = ggplot2::aes(
        yintercept = .data[[mapLabels$lloq]],
        color = .data[[mapLabels$color]]
      ),
      linetype = tlfEnv$defaultLLOQLinetype,
      size = aestheticValues$size,
      alpha = aestheticValues$alpha,
      na.rm = TRUE,
      show.legend = TRUE
    )
  return(plotObject)
}
