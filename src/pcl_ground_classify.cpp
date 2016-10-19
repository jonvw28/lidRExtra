//' @useDynLib lidRExtra
//' @importFrom Rcpp sourceCpp

#include <Rcpp.h>
#include <iostream>
#include <pcl/io/pcd_io.h>
#include <pcl/point_types.h>
#include <pcl/filters/extract_indices.h>
#include <pcl/segmentation/progressive_morphological_filter.h>

using namespace Rcpp;

//' Internal version of ground_classify
//' @export
// [[Rcpp::export]]
IntegerVector pcl_ground_classify(NumericVector X, NumericVector Y, NumericVector Z,
                                  int MaxWinSize = 20, float slope = 1.0,
                                  float InitDist = 0.5, float MaxDist = 3.0)
{
  int n = X.size();

  pcl::PointCloud<pcl::PointXYZ>::Ptr cloud (new pcl::PointCloud<pcl::PointXYZ>);
  pcl::PointIndicesPtr ground (new pcl::PointIndices);

  // Fill in the cloud data
  cloud->width    = n;
  cloud->height   = 1;
  cloud->is_dense = false;
  cloud->resize (cloud->width * cloud->height);

  for (int i = 0; i < n; ++i)
  {
    cloud->points[i].x = X(i);
    cloud->points[i].y = Y(i);
    cloud->points[i].z = Z(i);
  }

  // Create the filtering object
  pcl::ProgressiveMorphologicalFilter<pcl::PointXYZ> pmf;
  pmf.setInputCloud (cloud);
  pmf.setMaxWindowSize (MaxWinSize);
  pmf.setSlope (slope);
  pmf.setInitialDistance (InitDist);
  pmf.setMaxDistance (MaxDist);
  pmf.extract (ground->indices);

  IntegerVector output(ground->indices.size());

  for (size_t i = 0; i < ground->indices.size(); ++i)
    output(i) = ground->indices[i];

  return(output+1);
}


