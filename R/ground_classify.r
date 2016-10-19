# ===============================================================================
#
# PROGRAMMERS:
#
# jean-romain.roussel.1@ulaval.ca  -  https://github.com/Jean-Romain/lidR
#
# COPYRIGHT:
#
# Copyright 2016 Jean-Romain Roussel
#
# This file is part of lidRExtra R package.
#
# lidR is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>
#
# ===============================================================================


#' Classify points as ground or not ground
#'
#' This function is a wrapper for the Progressive Morphological Filter for segmentation
#' of ground points implemented in PCL (Point Cloud Library, see references).
#'
#' @param obj LAS objet
#' @param MaxWinSize param of the algorithm
#' @param slope param of the algorithm
#' @param InitDist param of the algorithm
#' @param MaxDist param of the algorithm
#' @return Nothing. The original object is updated by reference. The 'Classification'
#' column contains 1 for non-ground and 2 for ground according to LAS specifications.
#' @references
#' Zhang, K., Chen, S. C., Whitman, D., Shyu, M. L., Yan, J., & Zhang, C. (2003). A progressive morphological filter for removing nonground measurements from airborne LIDAR data. IEEE Transactions on Geoscience and Remote Sensing, 41(4 PART I), 872–882. http://doi.org/10.1109/TGRS.2003.810682
#' R. B. Rusu and S. Cousins, "3D is here: Point Cloud Library (PCL)," Robotics and Automation (ICRA), 2011 IEEE International Conference on, Shanghai, 2011, pp. 1-4. doi: 10.1109/ICRA.2011.5980567
#' @export
#' @examples
#' \dontrun{
#' LASfile <- system.file("extdata", "Topography.laz", package="lidR")
#'
#' lidar = readLAS(LASfile)
#'
#' ground_classify(lidar)
#' plot(lidar, color = "Classification")
#' }
#' @seealso
#' \link[lidR:LAS-class]{LAS}
#' @importFrom data.table :=
setGeneric("ground_classify", function(obj, MaxWinSize = 20, slope = 1.0, InitDist = 0.5, MaxDist = 3.0){standardGeneric("ground_classify")})

#' @rdname ground_classify
setMethod("ground_classify", "LAS",
  function(obj, MaxWinSize = 20, slope = 1.0, InitDist = 0.5, MaxDist = 3.0)
  {
    X <- Y <- Z <- NULL

    indices = obj@data %$% pcl_ground_classify(X, Y, Z, MaxWinSize, slope, InitDist, MaxDist)
    cl = rep(1, nrow(obj@data))
    cl[indices] = 2
    obj@data[,Classification := cl][]

    return(invisible(NULL))
  }
)
