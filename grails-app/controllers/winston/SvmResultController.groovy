package winston

import grails.plugin.springsecurity.annotation.Secured
import sk.upjs.winston.Role

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
@Secured([Role.ROLE_USER])
class SvmResultController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond SvmResult.list(params), model:[svmResultInstanceCount: SvmResult.count()]
    }

    def show(SvmResult svmResultInstance) {
        respond svmResultInstance
    }

    def create() {
        respond new SvmResult(params)
    }

    @Transactional
    def save(SvmResult svmResultInstance) {
        if (svmResultInstance == null) {
            notFound()
            return
        }

        if (svmResultInstance.hasErrors()) {
            respond svmResultInstance.errors, view:'create'
            return
        }

        svmResultInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'svmResult.label', default: 'SvmResult'), svmResultInstance.id])
                redirect svmResultInstance
            }
            '*' { respond svmResultInstance, [status: CREATED] }
        }
    }

    def edit(SvmResult svmResultInstance) {
        respond svmResultInstance
    }

    @Transactional
    def update(SvmResult svmResultInstance) {
        if (svmResultInstance == null) {
            notFound()
            return
        }

        if (svmResultInstance.hasErrors()) {
            respond svmResultInstance.errors, view:'edit'
            return
        }

        svmResultInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'SvmResult.label', default: 'SvmResult'), svmResultInstance.id])
                redirect svmResultInstance
            }
            '*'{ respond svmResultInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(SvmResult svmResultInstance) {

        if (svmResultInstance == null) {
            notFound()
            return
        }

        svmResultInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'SvmResult.label', default: 'SvmResult'), svmResultInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'svmResult.label', default: 'SvmResult'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
