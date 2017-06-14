
# Table of Contents
 <p><div class="lev1 toc-item"><a href="#Constraint-Satisfaction-Problems-(CSPs)" data-toc-modified-id="Constraint-Satisfaction-Problems-(CSPs)-1"><span class="toc-item-num">1&nbsp;&nbsp;</span>Constraint Satisfaction Problems (CSPs)</a></div><div class="lev2 toc-item"><a href="#Review" data-toc-modified-id="Review-11"><span class="toc-item-num">1.1&nbsp;&nbsp;</span>Review</a></div><div class="lev2 toc-item"><a href="#Graph-Coloring" data-toc-modified-id="Graph-Coloring-12"><span class="toc-item-num">1.2&nbsp;&nbsp;</span>Graph Coloring</a></div><div class="lev2 toc-item"><a href="#NQueens" data-toc-modified-id="NQueens-13"><span class="toc-item-num">1.3&nbsp;&nbsp;</span>NQueens</a></div><div class="lev3 toc-item"><a href="#Helper-Functions" data-toc-modified-id="Helper-Functions-131"><span class="toc-item-num">1.3.1&nbsp;&nbsp;</span>Helper Functions</a></div><div class="lev1 toc-item"><a href="#Backtracking-Search" data-toc-modified-id="Backtracking-Search-2"><span class="toc-item-num">2&nbsp;&nbsp;</span>Backtracking Search</a></div><div class="lev2 toc-item"><a href="#Graph-Coloring-Visualization" data-toc-modified-id="Graph-Coloring-Visualization-21"><span class="toc-item-num">2.1&nbsp;&nbsp;</span>Graph Coloring Visualization</a></div><div class="lev2 toc-item"><a href="#NQueens-Visualization" data-toc-modified-id="NQueens-Visualization-22"><span class="toc-item-num">2.2&nbsp;&nbsp;</span>NQueens Visualization</a></div>

# Constraint Satisfaction Problems (CSPs)

This IPy notebook acts as supporting material for topics covered in **Chapter 6 Constraint Satisfaction Problems** of the book* Artificial Intelligence: A Modern Approach*. We make use of the implementations in **csp.py** module. Even though this notebook includes a brief summary of the main topics familiarity with the material present in the book is expected. We will look at some visualizations and solve some of the CSP problems described in the book. Let us import everything from the csp module to get started.


```python
from csp import *
```

## Review

CSPs are a special kind of search problems. Here we don't treat the space as a black box but the state has a particular form and we use that to our advantage to tweak our algorithms to be more suited to the problems. A CSP State is defined by a set of variables which can take values from corresponding domains. These variables can take only certain values in their domains to satisfy the constraints. A set of assignments which satisfies all constraints passes the goal test. Let us start by exploring the CSP class which we will use to model our CSPs. You can keep the popup open and read the main page to get a better idea of the code.



```python
%psource CSP
```

The __ _ _init_ _ __ method parameters specify the CSP. Variable can be passed as a list of strings or integers. Domains are passed as dict where key specify the variables and value specify the domains. The variables are passed as an empty list. Variables are extracted from the keys of the domain dictionary. Neighbor is a dict of variables that essentially describes the constraint graph. Here each variable key has a list its value which are the variables that are constraint along with it. The constraint parameter should be a function **f(A, a, B, b**) that **returns true** if neighbors A, B **satisfy the constraint** when they have values **A=a, B=b**. We have additional parameters like nassings which is incremented each time an assignment is made when calling the assign method. You can read more about the methods and parameters in the class doc string. We will talk more about them as we encounter their use. Let us jump to an example.

## Graph Coloring

We use the graph coloring problem as our running example for demonstrating the different algorithms in the **csp module**. The idea of map coloring problem is that the adjacent nodes (those connected by edges) should not have the same color throughout the graph. The graph can be colored using a fixed number of colors. Here each node is a variable and the values are the colors that can be assigned to them. Given that the domain will be the same for all our nodes we use a custom dict defined by the **UniversalDict** class. The **UniversalDict** Class takes in a parameter which it returns as value for all the keys of the dict. It is very similar to **defaultdict** in Python except that it does not support item assignment.


```python
s = UniversalDict(['R','G','B'])
s[5]
```




    ['R', 'G', 'B']



For our CSP we also need to define a constraint function **f(A, a, B, b)**. In this what we need is that the neighbors must not have the same color. This is defined in the function **different_values_constraint** of the module.


```python
%psource different_values_constraint
```

The CSP class takes neighbors in the form of a Dict. The module specifies a simple helper function named **parse_neighbors** which allows to take input in the form of strings and return a Dict of the form compatible with the **CSP Class**.


```python
%pdoc parse_neighbors
```

The **MapColoringCSP** function creates and returns a CSP with the above constraint function and states. The variables our the keys of the neighbors dict and the constraint is the one specified by the **different_values_constratint** function. **australia**, **usa** and **france** are three CSPs that have been created using **MapColoringCSP**. **australia** corresponds to ** Figure 6.1 ** in the book.


```python
%psource MapColoringCSP
```


```python
australia, usa, france
```




    (<csp.CSP at 0x2023352ff60>,
     <csp.CSP at 0x20233543b70>,
     <csp.CSP at 0x20233554080>)



## NQueens

The N-queens puzzle is the problem of placing N chess queens on a N×N chessboard so that no two queens threaten each other. Here N is a natural number. Like the graph coloring, problem NQueens is also implemented in the csp module. The **NQueensCSP** class inherits from the **CSP** class. It makes some modifications in the methods to suit the particular problem. The queens are assumed to be placed one per column, from left to right. That means position (x, y) represents (var, val) in the CSP. The constraint that needs to be passed on the CSP is defined in the **queen_constraint** function. The constraint is satisfied (true) if A, B are really the same variable, or if they are not in the same row, down diagonal, or up diagonal. 


```python
%psource queen_constraint
```

The **NQueensCSP** method implements methods that support solving the problem via **min_conflicts** which is one of the techniques for solving CSPs. Because **min_conflicts** hill climbs the number of conflicts to solve the CSP **assign** and **unassign** are modified to record conflicts. More details about the structures **rows**, **downs**, **ups** which help in recording conflicts are explained in the docstring.


```python
%psource NQueensCSP
```

The _ ___init___ _ method takes only one parameter **n** the size of the problem. To create an instance we just pass the required n into the constructor.


```python
eight_queens = NQueensCSP(8)
```

### Helper Functions

We will now implement a few helper functions that will help us visualize the Coloring Problem. We will make some modifications to the existing Classes and Functions for additional book keeping. To begin we modify the **assign** and **unassign** methods in the **CSP** to add a copy of the assignment to the **assignment_history**. We call this new class **InstruCSP**. This will allow us to see how the assignment evolves over time.


```python
import copy
class InstruCSP(CSP):
    
    def __init__(self, variables, domains, neighbors, constraints):
        super().__init__(variables, domains, neighbors, constraints)
        self.assignment_history = []
        
    def assign(self, var, val, assignment):
        super().assign(var,val, assignment)
        self.assignment_history.append(copy.deepcopy(assignment))
    
    def unassign(self, var, assignment):
        super().unassign(var,assignment)
        self.assignment_history.append(copy.deepcopy(assignment))
```

Next, we define **make_instru** which takes an instance of **CSP** and returns a **InstruCSP** instance. 


```python
def make_instru(csp):
    return InstruCSP(csp.variables, csp.domains, csp.neighbors,
               csp.constraints)
```

We will now use a graph defined as a dictonary for plotting purposes in our Graph Coloring Problem. The keys are the nodes and their corresponding values are the nodes they are connected to.


```python
neighbors = {
    0: [6, 11, 15, 18, 4, 11, 6, 15, 18, 4], 
    1: [12, 12, 14, 14], 
    2: [17, 6, 11, 6, 11, 10, 17, 14, 10, 14], 
    3: [20, 8, 19, 12, 20, 19, 8, 12], 
    4: [11, 0, 18, 5, 18, 5, 11, 0], 
    5: [4, 4], 
    6: [8, 15, 0, 11, 2, 14, 8, 11, 15, 2, 0, 14], 
    7: [13, 16, 13, 16], 
    8: [19, 15, 6, 14, 12, 3, 6, 15, 19, 12, 3, 14], 
    9: [20, 15, 19, 16, 15, 19, 20, 16], 
    10: [17, 11, 2, 11, 17, 2], 
    11: [6, 0, 4, 10, 2, 6, 2, 0, 10, 4], 
    12: [8, 3, 8, 14, 1, 3, 1, 14], 
    13: [7, 15, 18, 15, 16, 7, 18, 16], 
    14: [8, 6, 2, 12, 1, 8, 6, 2, 1, 12], 
    15: [8, 6, 16, 13, 18, 0, 6, 8, 19, 9, 0, 19, 13, 18, 9, 16], 
    16: [7, 15, 13, 9, 7, 13, 15, 9], 
    17: [10, 2, 2, 10], 
    18: [15, 0, 13, 4, 0, 15, 13, 4], 
    19: [20, 8, 15, 9, 15, 8, 3, 20, 3, 9], 
    20: [3, 19, 9, 19, 3, 9]
}
```

Now we are ready to create an InstruCSP instance for our problem. We are doing this for an instance of **MapColoringProblem** class which inherits from the **CSP** Class. This means that our **make_instru** function will work perfectly for it.


```python
coloring_problem = MapColoringCSP('RGBY', neighbors)
```


```python
coloring_problem1 = make_instru(coloring_problem)
```

# Backtracking Search

For solving a CSP the main issue with Naive search algorithms is that they can continue expanding obviously wrong paths. In backtracking search, we check constraints as we go. Backtracking is just the above idea combined with the fact that we are dealing with one variable at a time. Backtracking Search is implemented in the repository as the function **backtracking_search**. This is the same as **Figure 6.5** in the book. The function takes as input a CSP and few other optional parameters which can be used to further speed it up. The function returns the correct assignment if it satisfies the goal. We will discuss these later. Let us solve our **coloring_problem1** with **backtracking_search**.



```python
result = backtracking_search(coloring_problem1)
```


```python
result # A dictonary of assignments.
```




    {0: 'R',
     1: 'R',
     2: 'R',
     3: 'R',
     4: 'G',
     5: 'R',
     6: 'G',
     7: 'R',
     8: 'B',
     9: 'R',
     10: 'G',
     11: 'B',
     12: 'G',
     13: 'G',
     14: 'Y',
     15: 'Y',
     16: 'B',
     17: 'B',
     18: 'B',
     19: 'G',
     20: 'B'}



Let us also check the number of assignments made.


```python
coloring_problem1.nassigns
```




    21



Now let us check the total number of assignments and unassignments which is the length ofour assignment history.


```python
len(coloring_problem1.assignment_history)
```




    21



Now let us explore the optional keyword arguments that the **backtracking_search** function takes. These optional arguments help speed up the assignment further. Along with these, we will also point out to methods in the CSP class that help make this work. 

The first of these is **select_unassigned_variable**. It takes in a function that helps in deciding the order in which variables will be selected for assignment. We use a heuristic called Most Restricted Variable which is implemented by the function **mrv**. The idea behind **mrv** is to choose the variable with the fewest legal values left in its domain. The intuition behind selecting the **mrv** or the most constrained variable is that it allows us to encounter failure quickly before going too deep into a tree if we have selected a wrong step before. The **mrv** implementation makes use of another function **num_legal_values** to sort out the variables by a number of legal values left in its domain. This function, in turn, calls the **nconflicts** method of the **CSP** to return such values.



```python
%psource mrv
```


```python
%psource num_legal_values
```


```python
%psource CSP.nconflicts
```

Another ordering related parameter **order_domain_values** governs the value ordering. Here we select the Least Constraining Value which is implemented by the function **lcv**. The idea is to select the value which rules out the fewest values in the remaining variables. The intuition behind selecting the **lcv** is that it leaves a lot of freedom to assign values later. The idea behind selecting the mrc and lcv makes sense because we need to do all variables but for values, we might better try the ones that are likely. So for vars, we face the hard ones first.



```python
%psource lcv
```

Finally, the third parameter **inference** can make use of one of the two techniques called Arc Consistency or Forward Checking. The details of these methods can be found in the **Section 6.3.2** of the book. In short the idea of inference is to detect the possible failure before it occurs and to look ahead to not make mistakes. **mac** and **forward_checking** implement these two techniques. The **CSP** methods **support_pruning**, **suppose**, **prune**, **choices**, **infer_assignment** and **restore** help in using these techniques. You can know more about these by looking up the source code.

Now let us compare the performance with these parameters enabled vs the default parameters. We will use the Graph Coloring problem instance usa for comparison. We will call the instances **solve_simple** and **solve_parameters** and solve them using backtracking and compare the number of assignments.


```python
solve_simple = copy.deepcopy(usa)
solve_parameters = copy.deepcopy(usa)
```


```python
backtracking_search(solve_simple)
backtracking_search(solve_parameters, order_domain_values=lcv, select_unassigned_variable=mrv, inference=mac )
```




    {'AL': 'R',
     'AR': 'R',
     'AZ': 'G',
     'CA': 'Y',
     'CO': 'B',
     'CT': 'B',
     'DC': 'G',
     'DE': 'G',
     'FL': 'G',
     'GA': 'B',
     'IA': 'R',
     'ID': 'G',
     'IL': 'Y',
     'IN': 'G',
     'KA': 'R',
     'KY': 'R',
     'LA': 'G',
     'MA': 'R',
     'MD': 'R',
     'ME': 'R',
     'MI': 'R',
     'MN': 'B',
     'MO': 'B',
     'MS': 'B',
     'MT': 'B',
     'NC': 'R',
     'ND': 'R',
     'NE': 'Y',
     'NH': 'G',
     'NJ': 'R',
     'NM': 'R',
     'NV': 'R',
     'NY': 'G',
     'OH': 'Y',
     'OK': 'G',
     'OR': 'B',
     'PA': 'B',
     'RI': 'G',
     'SC': 'G',
     'SD': 'G',
     'TN': 'G',
     'TX': 'B',
     'UT': 'Y',
     'VA': 'B',
     'VT': 'B',
     'WA': 'R',
     'WI': 'G',
     'WV': 'G',
     'WY': 'R'}




```python
solve_simple.nassigns
```




    49




```python
solve_parameters.nassigns
```




    49



## Graph Coloring Visualization

Next, we define some functions to create the visualisation from the assignment_history of **coloring_problem1**. The reader need not concern himself with the code that immediately follows as it is the usage of Matplotib with IPython Widgets. If you are interested in reading more about these visit [ipywidgets.readthedocs.io](http://ipywidgets.readthedocs.io). We will be using the **networkx** library to generate graphs. These graphs can be treated as the graph that needs to be colored or as a constraint graph for this problem. If interested you can read a dead simple tutorial [here](https://www.udacity.com/wiki/creating-network-graphs-with-python). We start by importing the necessary libraries and initializing matplotlib inline.



```python
%matplotlib inline
import networkx as nx
import matplotlib.pyplot as plt
import matplotlib
import time
```

The ipython widgets we will be using require the plots in the form of a step function such that there is a graph corresponding to each value. We define the **make_update_step_function** which return such a function. It takes in as inputs the neighbors/graph along with an instance of the **InstruCSP**. This will be more clear with the example below. If this sounds confusing do not worry this is not the part of the core material and our only goal is to help you visualize how the process works.


```python
def make_update_step_function(graph, instru_csp):
    
    def draw_graph(graph):
        # create networkx graph
        G=nx.Graph(graph)
        # draw graph
        pos = nx.spring_layout(G,k=0.15)
        return (G, pos)
    
    G, pos = draw_graph(graph)
    
    def update_step(iteration):
        # here iteration is the index of the assignment_history we want to visualize.
        current = instru_csp.assignment_history[iteration]
        #  We convert the particular assignment to a default dict so that the color for nodes which 
        # have not been assigned defaults to black.
        current = defaultdict(lambda: 'Black', current)

        # Now we use colors in the list and default to black otherwise.
        colors = [current[node] for node in G.node.keys()]
        # Finally drawing the nodes.
        nx.draw(G, pos, node_color=colors, node_size=500)

        labels = {label:label for label in G.node}
        # Labels shifted by offset so as to not overlap nodes.
        label_pos = {key:[value[0], value[1]+0.03] for key, value in pos.items()}
        nx.draw_networkx_labels(G, label_pos, labels, font_size=20)

        # show graph
        plt.show()

    return update_step  # <-- this is a function

def make_visualize(slider):
    ''' Takes an input a slider and returns 
        callback function for timer and animation
    '''
    
    def visualize_callback(Visualize, time_step):
        if Visualize is True:
            for i in range(slider.min, slider.max + 1):
                slider.value = i
                time.sleep(float(time_step))
    
    return visualize_callback
    
```

Finally let us plot our problem. We first use the function above to obtain a step function.


```python
step_func = make_update_step_function(neighbors, coloring_problem1)
```

Next we set the canvas size.


```python
matplotlib.rcParams['figure.figsize'] = (18.0, 18.0)
```

Finally our plot using ipywidget slider and matplotib. You can move the slider to experiment and see the coloring change. It is also possible to move the slider using arrow keys or to jump to the value by directly editing the number with a double click. The **Visualize Button** will automatically animate the slider for you. The **Extra Delay Box** allows you to set time delay in seconds upto one second for each time step.


```python
import ipywidgets as widgets
from IPython.display import display

iteration_slider = widgets.IntSlider(min=0, max=len(coloring_problem1.assignment_history)-1, step=1, value=0)
w=widgets.interactive(step_func,iteration=iteration_slider)
display(w)

visualize_callback = make_visualize(iteration_slider)

visualize_button = widgets.ToggleButton(desctiption = "Visualize", value = False)
time_select = widgets.ToggleButtons(description='Extra Delay:',options=['0', '0.1', '0.2', '0.5', '0.7', '1.0'])

a = widgets.interactive(visualize_callback, Visualize = visualize_button, time_step=time_select)
display(a)
```

    d:\python3.6\lib\site-packages\networkx\drawing\nx_pylab.py:126: MatplotlibDeprecationWarning: pyplot.hold is deprecated.
        Future behavior will be consistent with the long-time default:
        plot commands add elements without first clearing the
        Axes and/or Figure.
      b = plt.ishold()
    d:\python3.6\lib\site-packages\networkx\drawing\nx_pylab.py:138: MatplotlibDeprecationWarning: pyplot.hold is deprecated.
        Future behavior will be consistent with the long-time default:
        plot commands add elements without first clearing the
        Axes and/or Figure.
      plt.hold(b)
    d:\python3.6\lib\site-packages\matplotlib\__init__.py:917: UserWarning: axes.hold is deprecated. Please remove it from your matplotlibrc and/or style files.
      warnings.warn(self.msg_depr_set % key)
    d:\python3.6\lib\site-packages\matplotlib\rcsetup.py:152: UserWarning: axes.hold is deprecated, will be removed in 3.0
      warnings.warn("axes.hold is deprecated, will be removed in 3.0")
    


![png](output_58_1.png)


    Widget Javascript not detected.  It may not be installed or enabled properly.
    



## NQueens Visualization

Just like the Graph Coloring Problem we will start with defining a few helper functions to help us visualize the assignments as they evolve over time. The **make_plot_board_step_function** behaves similar to the **make_update_step_function** introduced earlier. It initializes a chess board in the form of a 2D grid with alternating 0s and 1s. This is used by **plot_board_step** function which draws the board using matplotlib and adds queens to it. This function also calls the **label_queen_conflicts** which modifies the grid placing 3 in positions in a position where there is a conflict.


```python
def label_queen_conflicts(assignment,grid):
    ''' Mark grid with queens that are under conflict. '''
    for col, row in assignment.items(): # check each queen for conflict
        row_conflicts = {temp_col:temp_row for temp_col,temp_row in assignment.items() 
                         if temp_row == row and temp_col != col}
        up_conflicts = {temp_col:temp_row for temp_col,temp_row in assignment.items() 
                        if temp_row+temp_col == row+col and temp_col != col}
        down_conflicts = {temp_col:temp_row for temp_col,temp_row in assignment.items() 
                          if temp_row-temp_col == row-col and temp_col != col}
        
        # Now marking the grid.
        for col, row in row_conflicts.items():
                grid[col][row] = 3
        for col, row in up_conflicts.items():
                grid[col][row] = 3
        for col, row in down_conflicts.items():
                grid[col][row] = 3

    return grid

def make_plot_board_step_function(instru_csp):
    '''ipywidgets interactive function supports
       single parameter as input. This function
       creates and return such a function by taking
       in input other parameters.
    '''
    n = len(instru_csp.variables)
    
    
    def plot_board_step(iteration):
        ''' Add Queens to the Board.'''
        data = instru_csp.assignment_history[iteration]
        
        grid = [[(col+row+1)%2 for col in range(n)] for row in range(n)]
        grid = label_queen_conflicts(data, grid) # Update grid with conflict labels.
        
        # color map of fixed colors
        cmap = matplotlib.colors.ListedColormap(['white','lightsteelblue','red'])
        bounds=[0,1,2,3] # 0 for white 1 for black 2 onwards for conflict labels (red).
        norm = matplotlib.colors.BoundaryNorm(bounds, cmap.N)
        
        fig = plt.imshow(grid, interpolation='nearest', cmap = cmap,norm=norm)

        plt.axis('off')
        fig.axes.get_xaxis().set_visible(False)
        fig.axes.get_yaxis().set_visible(False)

        # Place the Queens Unicode Symbol
        for col, row in data.items():
            fig.axes.text(row, col, u"\u265B", va='center', ha='center', family='Dejavu Sans', fontsize=32)
        plt.show()
    
    return plot_board_step
```

Now let us visualize a solution obtained via backtracking. We use of the previosuly defined **make_instru** function for keeping a history of steps.


```python
twelve_queens_csp = NQueensCSP(12)
backtracking_instru_queen = make_instru(twelve_queens_csp)
result = backtracking_search(backtracking_instru_queen)
```


```python
backtrack_queen_step = make_plot_board_step_function(backtracking_instru_queen) # Step Function for Widgets
```

Now finally we set some matplotlib parameters to adjust how our plot will look. The font is necessary because the Black Queen Unicode character is not a part of all fonts. You can move the slider to experiment and observe the how queens are assigned. It is also possible to move the slider using arrow keys or to jump to the value by directly editing the number with a double click.The **Visualize Button** will automatically animate the slider for you. The **Extra Delay Box** allows you to set time delay in seconds upto one second for each time step.



```python
matplotlib.rcParams['figure.figsize'] = (8.0, 8.0)
matplotlib.rcParams['font.family'].append(u'Dejavu Sans')

iteration_slider = widgets.IntSlider(min=0, max=len(backtracking_instru_queen.assignment_history)-1, step=0, value=0)
w=widgets.interactive(backtrack_queen_step,iteration=iteration_slider)
display(w)

visualize_callback = make_visualize(iteration_slider)

visualize_button = widgets.ToggleButton(desctiption = "Visualize", value = False)
time_select = widgets.ToggleButtons(description='Extra Delay:',options=['0', '0.1', '0.2', '0.5', '0.7', '1.0'])

a = widgets.interactive(visualize_callback, Visualize = visualize_button, time_step=time_select)
display(a)
```


![png](output_65_0.png)


    Widget Javascript not detected.  It may not be installed or enabled properly.
    



Now let us finally repeat the above steps for **min_conflicts** solution.


```python
conflicts_instru_queen = make_instru(twelve_queens_csp)
result = min_conflicts(conflicts_instru_queen)
```


```python
conflicts_step = make_plot_board_step_function(conflicts_instru_queen)
```

The visualization has same features as the above. But here it also highlights the conflicts by labeling the conflicted queens with a red background.

iteration_slider = widgets.IntSlider(min=0, max=len(conflicts_instru_queen.assignment_history)-1, step=0, value=0)
w=widgets.interactive(conflicts_step,iteration=iteration_slider)
display(w)

visualize_callback = make_visualize(iteration_slider)

visualize_button = widgets.ToggleButton(desctiption = "Visualize", value = False)
time_select = widgets.ToggleButtons(description='Extra Delay:',options=['0', '0.1', '0.2', '0.5', '0.7', '1.0'])

a = widgets.interactive(visualize_callback, Visualize = visualize_button, time_step=time_select)
display(a)




```python

```
