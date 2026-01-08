import pandas as pd
import csv
from scipy.spatial.distance import euclidean
from scipy.spatial.distance import cityblock



def main():
    k=5

    train_set_path = 'train_set.csv'  
    output_path = 'distances.csv'
    test_set_path = 'test_set.csv'
		
    
    test_set(test_set_path, train_set_path, output_path, k )
    
  
def read_csv (csv_path):
    csv_data = pd.read_csv(csv_path)
    return csv_data


	
def test_set(test_set_path, train_set_path, output_path, k):
    test_set = read_csv(test_set_path)
    success = [0,0]
    for index, data in test_set.iterrows():
        test_point = (data['X'],data['Y'])
        distance_calc(train_set_path,output_path,test_point)
        group_arr_by_dist = group_by_distance(output_path,k)
        success_rate(group_arr_by_dist, success)
        print(f"""The Clssification of test point number:{index+1},
              X coordinate:{data['X']},Y coordinate:{data['Y']}, 
              by the euclidian distance is:{group_arr_by_dist[0]}\n\n""")
    print_better_method(success)
       
      
      
   
		
def distance_calc(train_set_path, output_path, test_set_point):
    train_set = read_csv(train_set_path)
    header = ['Sample Number','Euclidian Distance','Euclidian Fixed Distance','Manhattan Distance','Group']
    with open(output_path , mode= 'w', newline='') as file:
        writer = csv.writer(file)
        writer.writerow(header)

        for index, sample_num in train_set.iterrows():
            sample = sample_num['Sample Number']
            x_i = sample_num['X']
            y_i = sample_num['Y']
            group_i = sample_num['Group']
            point2 = (x_i, y_i)
            euc_distance = euclidean(test_set_point, point2)
            fixed_euc_distance = round(euc_distance)
            manhattan_distance = cityblock(test_set_point, point2)
            content = [sample,euc_distance,fixed_euc_distance,manhattan_distance,group_i]
            writer.writerow(content)



def group_by_distance(output_path, k):
		
    distances = read_csv(output_path)
    # print(distances)
    point_class_arr = []
    sort_by_arr = ['Euclidian Distance','Euclidian Fixed Distance','Manhattan Distance']
    for distance in sort_by_arr:
        # print(distance)
        sorted_dis = distances.sort_values (distance, ascending = True )

        # print(sorted_dis)

        sum = 0
        for key , data in sorted_dis.iloc[:5].iterrows():
            sum += data['Group']

        if sum < k/2: 
            point_class_arr.append(0)
        else:
            point_class_arr.append(1)
    

    return point_class_arr
  
def success_rate (group_arr_by_dist, success):  
    if group_arr_by_dist[0] == group_arr_by_dist[1]:
        success[0] += 1
    if group_arr_by_dist[0] == group_arr_by_dist[2]:
  	    success[1] += 1
  

    # print(arry)

    
def print_better_method(success):
    print(success)
    if success[0] > success[1]:
        print('The optimal distance measurement method is: Euclidian Fixed Distance') 
    elif success[0] < success[1]:
        print('The optimal distance measurement method is: Manhattan Distance')
    else:
        print('Both methods are equal')
    

    
    
  
    
if __name__ == "__main__":
    main()
