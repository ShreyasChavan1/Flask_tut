from flask import Flask,render_template,request,session,redirect
from werkzeug.utils import secure_filename
from flask_mail import Mail
from flask_sqlalchemy import SQLAlchemy
import json
import os
from datetime import datetime

# we are reading the json file using json library and saving data in params variable and declaring it in every template to use paramters in it
with open('config.json','r') as f:
    params = json.load(f)["params"]

local = True

app = Flask(__name__,template_folder='template')
app.secret_key = 'the random string'
# for uploader
app.config['UPLOAD_FOLDER'] = params['upload_location']
# we have to do following configs for sending a mail you can determine the email account in jason file on which you  want the emails to receieve
app.config.update(
    MAIL_SERVER = "smtp.gmail.com",
    MAIL_PORT = "465",
    MAIL_USE_SSL = True,
    MAIL_USERNAME = params['gmail-user'],
    MAIL_PASSWORD = params['gmail-password'] 
)
mail = Mail(app)
if (local):
    app.config['SQLALCHEMY_DATABASE_URI'] = params['local_server']
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['prod_server']

# created object form sqlalchemy to connect to database  
db = SQLAlchemy(app)

class Contact(db.Model):
    # srno,name,mobile,msg,email,date
    srno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80),  nullable=False)
    mobile = db.Column(db.String(12) , nullable=False)
    msg = db.Column(db.String(120),  nullable=False)
    email = db.Column(db.String(50) , nullable=False)
    date = db.Column(db.String(120),  nullable=True)

class Posts(db.Model):
    # method of fecthing data from database 
    # srno,name,mobile,msg,email,date
    srno = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(80),  nullable=False)
    tagline = db.Column(db.String(20),  nullable=True)
    slug = db.Column(db.String(12) , nullable=False)
    content = db.Column(db.String(120),  nullable=False)
    date = db.Column(db.String(120),  nullable=True)
    img_src = db.Column(db.String(20),  nullable=True)


#this decoretor shows the endpoint of url which is default(nothing)
@app.route('/')
def index():
    # this code fecthes all the posts from database till the desired no mensioned in json file
    # posts = Posts.query.filter_by().all()[0:params['no_posts']]
    # return render_template('index.html',params = params,posts = posts)
# updated
    page = request.args.get('page', 1, type=int)
    posts = Posts.query.order_by(Posts.date.desc()).paginate(page=page, per_page=params['no_posts'], error_out=False)
    return render_template('index.html', params=params, posts=posts)

@app.route('/about')
def about():
    return render_template('about.html',params = params)

@app.route('/uploader',methods = ['GET','POST'])
def upload():
    if ('user' in session and session['user'] == params['Admin']):
        if request.method == 'POST':
            f = request.files['file1']
            f.save(os.path.join(app.config['UPLOAD_FOLDER'],secure_filename(f.filename)))
            return 'uploaded successfully'

@app.route('/logout')
def logout():
    session.pop('user')
    return redirect('/dashboard')

@app.route('/delete/<string:srno>',methods=['GET', 'POST'])
def delete(srno):
    if ('user' in session and session['user'] == params['Admin']):
        # this code will filter out the post by srno and delete it from database
        posts = Posts.query.filter_by(srno = srno).first()
        db.session.delete(posts)
        db.session.commit()
    return redirect('/dashboard')


@app.route('/dashboard',methods = ['GET','POST'])
def admin():
    # this code checks if the admin user is already logged in or not if logged in it will directly load dashbaord


    if ('user' in session and session['user'] == params['Admin']):
    #      posts = Posts.query.filter_by().all()[0:params['no_posts']]
    #      return render_template('dashboard.html',params = params,posts = posts)

#updated
        page = request.args.get('page', 1, type=int)
        posts = Posts.query.order_by(Posts.date.desc()).paginate(page=page, per_page=params['no_posts'], error_out=False)
        return render_template('dashboard.html', params=params, posts=posts)

    # if any user is not logged in and website is giving post request then it will check the username and passsord from form matches the 
    # username and password given in json file
    if request.method == 'POST':
        username = request.form.get('uname')
        password = request.form.get('upass')
        if (username == params['Admin'] and password == params['password']):
            # we have to set the sessionn before login in 
            session['user'] = username
            posts = Posts.query.all()
            return render_template('dashboard.html',params = params,posts = posts)
    # if user is not logged in or  username or password does not match then it will again ask for login 
    else:
        return render_template('login.html',params = params)


@app.route('/edit/<string:srno>', methods=['GET', 'POST'])
def edit(srno):
    if 'user' in session and session['user'] == params['Admin']:
        if request.method == 'POST':
            title = request.form.get('title')
            slugg = request.form.get('slug')
            tag_line = request.form.get('tline')
            content = request.form.get('content')
            img_file = request.form.get('img')
            date = datetime.now()
            if srno == '0':
                new_post = Posts(title=title, slug=slugg, tagline=tag_line, content=content, img_src=img_file, date=date)
                db.session.add(new_post)
                db.session.commit()
            else:
                post = Posts.query.filter_by(srno=srno).first()
                post.title = title
                post.slug = slugg
                post.tagline = tag_line
                post.content = content
                post.img_src = img_file
                post.date = date
                db.session.commit()
            return redirect('/edit/' + srno)
    post = Posts.query.filter_by(srno=srno).first()
    return render_template('edit.html', post=post, params=params,srno = srno)


@app.route('/contact',methods=['GET', 'POST'])
def contact():
    # below code is getting the inputs from contact from through their names
    if request.method == 'POST':
        name1 = request.form.get('name')
        phone = request.form.get('phone')
        mesg = request.form.get('message')
        mael = request.form.get('email')
        entry = Contact(name = name1 , mobile = phone,msg = mesg, email=mael,date = datetime.now())
        db.session.add(entry)
        db.session.commit()
        # to send message use send_message fucntion
        mail.send_message('new messeage from '+name1,sender = mael,recipients = [params['gmail-user']],body = mesg + "/n" + phone)
    return render_template('contact.html',params = params)
# see database codewithme
# the string is variable if it is = to slug in database then load the post.html related to slug
@app.route('/post/<string:post_slug>',methods=['GET'])
def post_route(post_slug):
    post = Posts.query.filter_by(slug = post_slug).first()
    return render_template('post.html',params = params,post = post)



if __name__ == '__main__':
    app.run(debug=True)